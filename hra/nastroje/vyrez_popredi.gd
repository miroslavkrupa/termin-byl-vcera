# Vyřízne z pozadí místnosti část, která má být před postavami (popředí, F0/R2), např. kašnu.
# Spuštění: godot --headless --path hra --script res://nastroje/vyrez_popredi.gd -- <pozadí.png> <výstup.png> "<x,y x,y …>" [posun_x]
# Obrys je v souřadnicích místnosti (1536 × 1024). Pozadí širší než místnost (19,5:9) má obsah
# posunutý doprava o posun_x (u náměstí 341 px). Výstup je obdélník kolem obrysu; pixely mimo
# obrys jsou průhledné, okraj obrysu je změkčený o 1 px. Vypíše, kam obrázek v místnosti patří.
extends SceneTree


func _init() -> void:
	var a := OS.get_cmdline_user_args()
	if a.size() < 3:
		push_error("Použití: -- <pozadí.png> <výstup.png> \"<x,y x,y …>\" [posun_x]")
		quit(1)
		return
	var posun := int(a[3]) if a.size() > 3 else 0
	var obrys := PackedVector2Array()
	for bod in a[2].split(" ", false):
		var xy := bod.split(",")
		obrys.append(Vector2(float(xy[0]), float(xy[1])))
	var pozadi := Image.load_from_file(a[0])
	pozadi.convert(Image.FORMAT_RGBA8)
	var r := Rect2i(Rect2(obrys[0], Vector2.ZERO).expand(obrys[0]))
	for b in obrys:
		r = r.expand(Vector2i(b))
	r = r.grow(2)
	var vystup := Image.create(r.size.x, r.size.y, false, Image.FORMAT_RGBA8)
	vystup.fill(Color(0, 0, 0, 0))
	for y in r.size.y:
		for x in r.size.x:
			var bod := Vector2(r.position.x + x + 0.5, r.position.y + y + 0.5)
			var kryti := _kryti(bod, obrys)
			if kryti <= 0.0:
				continue
			var c := pozadi.get_pixel(r.position.x + x + posun, r.position.y + y)
			c.a *= kryti
			vystup.set_pixel(x, y, c)
	vystup.save_png(a[1])
	print("Obrázek %s × %s, střed v místnosti %s, spodní okraj y = %d" % [r.size.x, r.size.y, Vector2(r.get_center()), r.end.y])
	quit()


# Podíl pixelu uvnitř obrysu (4 × 4 vzorky), aby okraj nebyl zubatý
func _kryti(bod: Vector2, obrys: PackedVector2Array) -> float:
	var uvnitr := 0
	for i in 4:
		for j in 4:
			if Geometry2D.is_point_in_polygon(bod + Vector2((i - 1.5) / 4.0, (j - 1.5) / 4.0), obrys):
				uvnitr += 1
	return uvnitr / 16.0
