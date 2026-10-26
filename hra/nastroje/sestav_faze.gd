# Zarovná fáze animace (obrázky celé postavy) na společné plátno: chodidla na stejnou čáru,
# hlava a trup na stejnou svislici. Bez zarovnání by postava při přehrávání poskakovala a cukala.
# Spuštění: godot --headless --path hra --script res://nastroje/sestav_faze.gd -- <složka s fázemi> <výstupní složka>
# Vstup: obrázky s průhledným pozadím seřazené podle názvu (např. z rozdel_casti.gd).
# Výstup: faze_01.png … se stejnou velikostí; bod mezi chodidly je uprostřed spodního okraje.
# U chůze (postava jde doprava) se navíc změří, o kolik se mezi fázemi posune noha, která stojí
# na zemi, a uloží se do faze.json. Hra pak střídá fáze podle ušlé vzdálenosti tak, aby chodidlo
# na zemi stálo na místě a neklouzalo („moonwalk“).
extends SceneTree

const HORNI_PODIL := 0.45   # svislice se počítá z horní části postavy (hlava a trup), nohy se hýbou
const OKRAJ := 8


func _init() -> void:
	var a := OS.get_cmdline_user_args()
	if a.size() < 2:
		push_error("Použití: -- <složka s fázemi> <výstupní složka>")
		quit(1)
		return
	var soubory := Array(DirAccess.get_files_at(a[0])).filter(func(f): return f.ends_with(".png"))
	soubory.sort()
	var faze: Array[Dictionary] = []
	for f in soubory:
		var img := Image.load_from_file(a[0].path_join(f))
		img.convert(Image.FORMAT_RGBA8)
		faze.append(_zmer(img))

	# Velikost se nemění: rozdíly výšky mezi fázemi jsou pohupování těla (pokrčené nohy).
	# (Srovnání podle výšky hlavy se nepovedlo: krk se v kresbě měří nepřesně a rozdíly zhoršilo.)
	var nejvyssi := 0
	for z in faze:
		nejvyssi = maxi(nejvyssi, z.obdelnik.size.y)

	var vlevo := 0
	var vpravo := 0
	for z in faze:
		vlevo = maxi(vlevo, int(z.svislice - z.obdelnik.position.x))
		vpravo = maxi(vpravo, int(z.obdelnik.end.x - z.svislice))
	var pul := maxi(vlevo, vpravo) + OKRAJ
	var w := 2 * pul
	var h := nejvyssi + OKRAJ

	DirAccess.make_dir_recursive_absolute(a[1])
	for i in faze.size():
		var z: Dictionary = faze[i]
		var platno := Image.create(w, h, false, Image.FORMAT_RGBA8)
		platno.fill(Color(0, 0, 0, 0))
		var cil := Vector2i(pul - int(z.svislice - z.obdelnik.position.x), h - z.obdelnik.size.y)
		platno.blend_rect(z.obrazek, z.obdelnik, cil)
		var cesta := a[1].path_join("faze_%02d.png" % (i + 1))
		platno.save_png(cesta)
		print("faze_%02d z %s, posun svislice %d px" % [i + 1, soubory[i], int(z.svislice - z.obdelnik.get_center().x)])
	var posuny := _posuny_chodidel(a[1], faze.size())
	var meta := FileAccess.open(a[1].path_join("faze.json"), FileAccess.WRITE)
	meta.store_string(JSON.stringify({vyska = h, vyska_prumer = _prumerna_vyska(faze), posuny = posuny}, "  "))
	meta.close()
	print("Posun stojící nohy mezi fázemi (px): ", posuny, ", celý cyklus ", posuny.reduce(func(x, y): return x + y, 0.0))
	print("Fází: %d, plátno %d × %d" % [faze.size(), w, h])
	quit()


# Obdélník neprůhledných pixelů a svislice = průměrné x neprůhledných pixelů v horní části postavy
func _zmer(img: Image) -> Dictionary:
	var obdelnik := img.get_used_rect()
	var horni := obdelnik.position.y + int(obdelnik.size.y * HORNI_PODIL)
	var soucet := 0.0
	var pocet := 0
	for y in range(obdelnik.position.y, horni):
		for x in range(obdelnik.position.x, obdelnik.end.x):
			if img.get_pixel(x, y).a > 0.5:
				soucet += x
				pocet += 1
	return {obrazek = img, obdelnik = obdelnik, svislice = soucet / maxi(pocet, 1)}



## Průměrná výška postavy ve fázích (podle ní se srovná velikost stání a chůze)
func _prumerna_vyska(faze: Array) -> float:
	return faze.reduce(func(soucet, z): return soucet + z.obdelnik.size.y, 0.0) / faze.size()


# Boty = souvislé úseky sloupců, které mají neprůhledný pixel ve spodních 20 % plátna.
# Vrací [[střed x, spodní y], …].
func _boty(img: Image) -> Array:
	var w := img.get_width()
	var h := img.get_height()
	var dna := []
	for x in w:
		var dno := -1
		for y in range(h - 1, int(h * 0.80), -1):
			if img.get_pixel(x, y).a > 0.5:
				dno = y
				break
		dna.append(dno)
	var boty := []
	var x0 := -1
	for x in w + 1:
		var je: bool = x < w and dna[x] >= 0
		if je and x0 < 0:
			x0 = x
		if not je and x0 >= 0:
			var nejnizsi := 0
			for xx in range(x0, x):
				nejnizsi = maxi(nejnizsi, dna[xx])
			boty.append([(x0 + x - 1) / 2.0, nejnizsi])
			x0 = -1
	return boty


# Mezi fází i a i+1: noha na zemi se posune dozadu (doleva). Bere se nejbližší dvojice bot na zemi,
# kde se bota posunula dozadu; výsledky se vyhladí, aby jedna nepřesná fáze nerozhodila rytmus.
func _posuny_chodidel(slozka: String, pocet: int) -> Array:
	var boty := []
	var zem := 0
	for i in pocet:
		var img := Image.load_from_file(slozka.path_join("faze_%02d.png" % (i + 1)))
		var b := _boty(img)
		boty.append(b)
		for x in b:
			zem = maxi(zem, x[1])
	var posuny := []
	for i in pocet:
		var ted: Array = boty[i].filter(func(x): return x[1] >= zem - 8)
		var dalsi: Array = boty[(i + 1) % pocet].filter(func(x): return x[1] >= zem - 8)
		var nejlepsi := INF
		for p in ted:
			for q in dalsi:
				var d: float = p[0] - q[0]
				if d > -10.0 and absf(d) < absf(nejlepsi):
					nejlepsi = d
		posuny.append(maxf(nejlepsi, 0.0) if nejlepsi != INF else -1.0)
	var platne := posuny.filter(func(d): return d >= 0.0)
	var prumer: float = platne.reduce(func(x, y): return x + y, 0.0) / maxi(platne.size(), 1)
	return posuny.map(func(d): return snappedf(0.5 * (d if d >= 0.0 else prumer) + 0.5 * prumer, 0.1))
