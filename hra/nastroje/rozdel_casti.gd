# Rozdělí list s částmi postavy (např. od ChatGPT) na samostatné obrázky, jeden na každou část.
# Spuštění: godot --headless --path hra --script res://nastroje/rozdel_casti.gd -- <list.png> <výstupní složka> [předpona]
#
# Obrázek s průhledným pozadím se dělí podle průhlednosti (přesné, doporučeno). Obrázek na bílém
# pozadí se nejdřív vyřízne nástrojem vyrez_postavy.gd a pak rozdělí. Části se očíslují po řádcích
# shora dolů a zleva doprava (<předpona>_01.png …) a vypíše se jejich poloha a velikost.
extends SceneTree

const MIN_PIXELU := 400   # menší skvrny jsou nečistoty, ne části postavy
const OKRAJ := 4          # průhledný okraj kolem každé části


func _init() -> void:
	var a := OS.get_cmdline_user_args()
	if a.size() < 2:
		push_error("Použití: -- <list.png> <výstupní složka> [předpona]")
		quit(1)
		return
	var predpona := a[2] if a.size() > 2 else "cast"
	var img := Image.load_from_file(a[0])
	img.convert(Image.FORMAT_RGBA8)
	var w := img.get_width()
	var h := img.get_height()

	var neprazdne := func(x: int, y: int) -> bool: return img.get_pixel(x, y).a > 0.1
	var znacka := PackedInt32Array()
	znacka.resize(w * h)
	znacka.fill(-1)
	var casti: Array[Dictionary] = []
	for y in h:
		for x in w:
			var i := y * w + x
			if znacka[i] != -1 or not neprazdne.call(x, y):
				continue
			# Souvislá část (8-sousedství, ať se neoddělí tenké linky)
			var obdelnik := Rect2i(x, y, 1, 1)
			var pocet := 0
			var zasobnik: Array[int] = [i]
			znacka[i] = casti.size()
			while not zasobnik.is_empty():
				var j: int = zasobnik.pop_back()
				var jx := j % w
				var jy := j / w
				pocet += 1
				obdelnik = obdelnik.expand(Vector2i(jx, jy))
				for dy in [-1, 0, 1]:
					for dx in [-1, 0, 1]:
						var nx: int = jx + dx
						var ny: int = jy + dy
						if nx < 0 or ny < 0 or nx >= w or ny >= h:
							continue
						var k := ny * w + nx
						if znacka[k] == -1 and neprazdne.call(nx, ny):
							znacka[k] = casti.size()
							zasobnik.append(k)
			casti.append({"id": casti.size(), "obdelnik": obdelnik.grow_individual(0, 0, 1, 1), "pocet": pocet})

	var velke := casti.filter(func(c): return c.pocet >= MIN_PIXELU)
	# Po řádcích: části, jejichž středy jsou svisle blízko, patří do stejného řádku
	velke.sort_custom(func(p, q): return p.obdelnik.get_center().y < q.obdelnik.get_center().y)
	var radky: Array = []
	for c in velke:
		if radky.is_empty() or c.obdelnik.get_center().y - radky[-1][0].obdelnik.get_center().y > h / 12:
			radky.append([c])
		else:
			radky[-1].append(c)
	var poradi: Array = []
	for r in radky:
		r.sort_custom(func(p, q): return p.obdelnik.position.x < q.obdelnik.position.x)
		poradi.append_array(r)

	DirAccess.make_dir_recursive_absolute(a[1])
	for n in poradi.size():
		var c: Dictionary = poradi[n]
		var r: Rect2i = c.obdelnik
		var vystup := Image.create(r.size.x + 2 * OKRAJ, r.size.y + 2 * OKRAJ, false, Image.FORMAT_RGBA8)
		vystup.fill(Color(0, 0, 0, 0))
		# Jen pixely této části (sousední část v obdélníku se nepřenese)
		for y in r.size.y:
			for x in r.size.x:
				var sx := r.position.x + x
				var sy := r.position.y + y
				if znacka[sy * w + sx] == c.id:
					vystup.set_pixel(x + OKRAJ, y + OKRAJ, img.get_pixel(sx, sy))
		var cesta := a[1].path_join("%s_%02d.png" % [predpona, n + 1])
		vystup.save_png(cesta)
		print("%s_%02d: poloha %s, velikost %s" % [predpona, n + 1, r.position, r.size])
	print("Částí: %d (vynecháno %d malých skvrn)" % [poradi.size(), casti.size() - poradi.size()])
	quit()
