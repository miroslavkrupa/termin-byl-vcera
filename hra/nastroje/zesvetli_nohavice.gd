# Zesvětlí tmavě modré odstíny kalhot ve fázích animace, aby vzdálená nohavice nebyla výrazně
# tmavší než bližší. Chůze bokem v03 ji má tmavší podle zadání (kvůli rozlišení nohou), ve hře
# to ale ruší. Stínování záhybů zůstane, jen se zmenší rozdíl mezi tmavou a světlou modrou.
# Spuštění: godot --headless --path hra --script res://nastroje/zesvetli_nohavice.gd -- <složka s fázemi>
# Upraví všechny faze_*.png ve složce na místě.
extends SceneTree

## Jas světlé modré kalhot; tmavší modrá se k němu přiblíží
const SVETLA := 0.56
## Kolik z rozdílu proti světlé modré zůstane (1 = beze změny, 0 = všechno stejně světlé)
const ZACHOVAT := 0.45


func _init() -> void:
	var a := OS.get_cmdline_user_args()
	if a.is_empty():
		push_error("Použití: -- <složka s fázemi>")
		quit(1)
		return
	for f in DirAccess.get_files_at(a[0]):
		if not (f.begins_with("faze_") and f.ends_with(".png")):
			continue
		var cesta := a[0].path_join(f)
		var img := Image.load_from_file(cesta)
		img.convert(Image.FORMAT_RGBA8)
		for y in img.get_height():
			for x in img.get_width():
				var c := img.get_pixel(x, y)
				# Modrá látka kalhot: modrý odstín, dost sytý, ne obrys (ten je skoro černý)
				if c.a > 0.5 and c.h > 0.53 and c.h < 0.66 and c.s > 0.25 and c.v > 0.3 and c.v < SVETLA:
					c.v = SVETLA - (SVETLA - c.v) * ZACHOVAT
					img.set_pixel(x, y, c)
		img.save_png(cesta)
	quit()
