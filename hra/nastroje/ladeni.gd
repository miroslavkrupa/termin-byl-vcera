# Ladicí pomocník pro ověřování prototypu bez ručního klikání.
# Bez parametrů nedělá nic. Spuštění se snímkem obrazovky:
#   godot --path hra -- snimek=<soubor.png> [jazyk=cs|en] [cekej=3] [dojdi=x,y | klik=x,y | akce=…] [po=3]
# cekej = sekundy před akcí, po = sekundy po akci; souřadnice hry (1536 × 1024)
# dojdi = hráčova postava dojde na místo (ověří navigaci a zmenšování)
# akce = <AktivniMisto>:pouzit|prohlednout|najet – klepnutí levým / pravým tlačítkem, nebo jen popisek jako při najetí myší
# volby = <id>,<id>… – po akci vybírá volby dialogu, vždy jakmile se nabídka zobrazí
# klik = simulované klepnutí; Popochiu ale čte skutečnou pozici kurzoru, takže míří tam, kde je myš
#
# Zakládání objektů Popochiu (viz nastroje/vytvor.gd):
#   godot --headless --path hra -- vytvor <příkaz> <argumenty>
extends Node


func _ready() -> void:
	var args := OS.get_cmdline_user_args()
	if args.size() > 0 and args[0] == "vytvor":
		var ok: bool = load("res://nastroje/vytvor.gd").new().spust(args.slice(1))
		get_tree().quit(0 if ok else 1)
		return
	var p := {}
	for arg in OS.get_cmdline_user_args():
		var c := arg.split("=", true, 1)
		if c.size() == 2:
			p[c[0]] = c[1]
	if p.has("jazyk"):
		TranslationServer.set_locale(p["jazyk"])
	if not p.has("snimek"):
		return
	# Repliky se při ladění posouvají samy (hráč je posouvá klepnutím)
	get_node("/root/E").settings.auto_continue_text = true
	await get_tree().create_timer(float(p.get("cekej", "3"))).timeout
	_vypis("před akcí")
	if p.has("dojdi"):
		var xy: PackedStringArray = p["dojdi"].split(",")
		get_node("/root/C").player.walk_to(Vector2(float(xy[0]), float(xy[1])))
	elif p.has("akce"):
		var c: PackedStringArray = p["akce"].split(":")
		var misto: PopochiuClickable = get_node("/root/R").current.get_hotspot(c[0])
		if c[1] == "najet":
			get_node("/root/G").hover_text_shown.emit(misto.get_description())
		else:
			get_node("/root/E").clicked = misto
			misto.handle_command(MOUSE_BUTTON_RIGHT if c[1] == "prohlednout" else MOUSE_BUTTON_LEFT)
	elif p.has("klik"):
		var xy: PackedStringArray = p["klik"].split(",")
		_klepnout(Vector2(float(xy[0]), float(xy[1])))
	if p.has("volby"):
		var d = get_node("/root/D")
		for id in p["volby"].split(","):
			await d.dialog_options_requested
			await get_tree().create_timer(0.8).timeout
			d.option_selected.emit(d.current_dialog.get_option(id))
	if p.has("dojdi") or p.has("akce") or p.has("klik"):
		await get_tree().create_timer(float(p.get("po", "3"))).timeout
		_vypis("po akci")
	get_viewport().get_texture().get_image().save_png(p["snimek"])
	print("Snímek uložen: ", p["snimek"])
	get_tree().quit()


# Klepnutí jako od hráče: souřadnice hry se převedou na souřadnice okna
func _klepnout(kde: Vector2) -> void:
	var okno := Vector2(get_window().size)
	var hra := Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	var pozice: Vector2 = kde * minf(okno.x / hra.x, okno.y / hra.y)
	for stisk in [true, false]:
		var e := InputEventMouseButton.new()
		e.button_index = MOUSE_BUTTON_LEFT
		e.pressed = stisk
		e.position = pozice
		e.global_position = pozice
		Input.parse_input_event(e)


func _vypis(kdy: String) -> void:
	var hrac = get_node("/root/C").player
	var kamera := get_viewport().get_camera_2d()
	var inventar: Array = get_node("/root/I").items
	print("[%s] hráč %s, měřítko %s, inventář %s, okno %s, viditelná oblast %s, kamera %s" % [
		kdy, hrac.position if hrac else "?", hrac.scale if hrac else "?", inventar, get_window().size,
		get_viewport().get_visible_rect(), kamera.get_screen_center_position() if kamera else "žádná"
	])
