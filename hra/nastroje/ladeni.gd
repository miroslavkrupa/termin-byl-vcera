# Ladicí pomocník pro ověřování prototypu bez ručního klikání.
# Bez parametrů nedělá nic. Spuštění se snímkem obrazovky:
#   godot --path hra -- snimek=<soubor.png> [cekej=3] [dojdi=x,y | klik=x,y] [po=3]
# cekej = sekundy před akcí, po = sekundy po akci; souřadnice hry (1536 × 1024)
# dojdi = hráčova postava dojde na místo (ověří navigaci a zmenšování)
# klik = simulované klepnutí; Popochiu ale čte skutečnou pozici kurzoru, takže míří tam, kde je myš
extends Node


func _ready() -> void:
	var p := {}
	for arg in OS.get_cmdline_user_args():
		var c := arg.split("=", true, 1)
		if c.size() == 2:
			p[c[0]] = c[1]
	if not p.has("snimek"):
		return
	await get_tree().create_timer(float(p.get("cekej", "3"))).timeout
	_vypis("před akcí")
	if p.has("dojdi"):
		var xy: PackedStringArray = p["dojdi"].split(",")
		get_node("/root/C").player.walk_to(Vector2(float(xy[0]), float(xy[1])))
	elif p.has("klik"):
		var xy: PackedStringArray = p["klik"].split(",")
		_klepnout(Vector2(float(xy[0]), float(xy[1])))
	if p.has("dojdi") or p.has("klik"):
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
	print("[%s] hráč %s, měřítko %s, okno %s, viditelná oblast %s, kamera %s" % [
		kdy, hrac.position if hrac else "?", hrac.scale if hrac else "?", get_window().size,
		get_viewport().get_visible_rect(), kamera.get_screen_center_position() if kamera else "žádná"
	])
