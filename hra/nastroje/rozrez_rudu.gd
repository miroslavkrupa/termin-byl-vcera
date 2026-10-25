# Rozřeže boční pohled Rudy na trup a nohu pro jednoduchou kloubovou (cutout) animaci chůze (krok K9).
# Spuštění: godot --headless --path hra --script res://nastroje/rozrez_rudu.gd
extends SceneTree

const ZDROJ := "res://grafika/postavy/ruda_zboku.png"
# Hranice v souřadnicích obrázku 360 × 1000 (boční pohled)
const TRUP_DO := 672                       # trup končí kus pod kyčlí, překryje horní okraj nohou
const NOHA := Rect2i(90, 655, 210, 345)    # noha od stehna po botu (pod deskami a rukou)


func _init() -> void:
	var img := Image.load_from_file(ProjectSettings.globalize_path(ZDROJ))
	img.convert(Image.FORMAT_RGBA8)

	var noha := img.get_region(NOHA)
	noha.save_png(ProjectSettings.globalize_path("res://grafika/postavy/ruda_bok_noha.png"))

	var trup: Image = img.duplicate()
	for y in range(TRUP_DO, trup.get_height()):
		for x in trup.get_width():
			trup.set_pixel(x, y, Color(0, 0, 0, 0))
	# Měkký přechod na spodním okraji trupu, ať není vidět rovný řez
	for y in range(TRUP_DO - 12, TRUP_DO):
		var k := float(TRUP_DO - y) / 12.0
		for x in trup.get_width():
			var c: Color = trup.get_pixel(x, y)
			c.a *= k
			trup.set_pixel(x, y, c)
	trup.save_png(ProjectSettings.globalize_path("res://grafika/postavy/ruda_bok_trup.png"))
	print("Uloženo: ruda_bok_trup.png, ruda_bok_noha.png")
	quit()
