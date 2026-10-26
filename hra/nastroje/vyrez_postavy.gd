# Vyřízne postavu z obrázku na bílém pozadí a udělá z pozadí průhlednost.
# Spuštění: godot --headless --path hra --script res://nastroje/vyrez_postavy.gd -- <vstup.png> <výstup.png> <x> <y> <šířka> <výška> [práh] [velikost] [ladit]
# práh = jak světlé musí být pozadí (0–1, výchozí 0.80; u bílých předmětů vyšší, např. 0.95)
# velikost = výsledek se zvětší/zmenší, aby delší strana měla tolik pixelů (0 = beze změny)
# ladit = uloží vedle výstupu i <výstup>_maska.png: červeně pozadí, zeleně uzavřené ostrůvky
#
# Postup (proti prvnímu pokusu, kde mezi vlasy zůstávala bílá místa a kolem obrysu bílý lem):
# 1. pozadí = světlé neutrální pixely spojené s okrajem výřezu,
# 2. uzavřené ostrůvky čisté bílé uvnitř postavy (mezery mezi prameny vlasů) jsou také pozadí,
#    pokud je obklopují tmavé pixely (vlasy) a není v nich tmavý ostrůvek (oko s panenkou);
#    světlé plochy v kresbě (hrnek, košile, lesky) tmavé okolí nemají,
# 3. pás kolem pozadí se „odbarví“: bílá složka se převede na průhlednost (color to alpha),
#    takže na hraně nezůstane bílý lem.
extends SceneTree

var prah := 0.80                # světlé neutrální pixely pozadí
const CISTA_BILA := 0.93        # ostrůvky uvnitř postavy musí být skoro čistě bílé
const NEUTRALNI := 0.10         # max. rozdíl kanálů, aby šlo o šedou/bílou, ne o barvu
const MIN_OSTROVEK := 6         # menší bílé ostrůvky jsou lesky v kresbě, ty zůstanou
const PAS := 3                  # šířka pásu kolem pozadí, který se odbarví
const NEPRUHLEDNE_POD := 0.55   # pixel tmavší než tohle v pásu zůstane plně neprůhledný

var w := 0
var h := 0


func _init() -> void:
	var a := OS.get_cmdline_user_args()
	if a.size() < 6:
		push_error("Použití: -- <vstup.png> <výstup.png> <x> <y> <šířka> <výška> [práh] [velikost] [ladit]")
		quit(1)
		return
	if a.size() > 6:
		prah = float(a[6])
	var zdroj := Image.load_from_file(a[0])
	var img := zdroj.get_region(Rect2i(int(a[2]), int(a[3]), int(a[4]), int(a[5])))
	img.convert(Image.FORMAT_RGBAF)
	w = img.get_width()
	h = img.get_height()

	# 1) pozadí spojené s okrajem
	var pozadi := PackedByteArray()
	pozadi.resize(w * h)
	var start: Array[int] = []
	for x in w:
		start.append(x)
		start.append((h - 1) * w + x)
	for y in h:
		start.append(y * w)
		start.append(y * w + w - 1)
	_vypln(img, pozadi, start, func(c: Color): return _svetle(c, prah))

	# 2) uzavřené bílé ostrůvky
	var ostrovky := PackedByteArray()
	ostrovky.resize(w * h)
	var navstiveno := pozadi.duplicate()
	for i in w * h:
		if navstiveno[i] == 0 and _svetle(img.get_pixel(i % w, i / w), CISTA_BILA):
			var oblast := _vypln(img, navstiveno, [i], func(c: Color): return _svetle(c, CISTA_BILA))
			if oblast.size() >= MIN_OSTROVEK and _tmave_okoli(img, oblast) and not _obsahuje_tmave(img, oblast):
				for j in oblast:
					ostrovky[j] = 1
	for i in w * h:
		if ostrovky[i] == 1:
			pozadi[i] = 1

	# 3) pozadí průhledné, pás kolem něj odbarvit
	var vzdalenost := _vzdalenost_od_pozadi(pozadi)
	for i in w * h:
		var x := i % w
		var y := i / w
		if pozadi[i] == 1:
			img.set_pixel(x, y, Color(0, 0, 0, 0))
		elif vzdalenost[i] <= PAS:
			img.set_pixel(x, y, _odbarvi(img.get_pixel(x, y)))

	img.convert(Image.FORMAT_RGBA8)
	if a.size() > 7 and int(a[7]) > 0:
		var k: float = float(a[7]) / maxi(w, h)
		img.resize(int(w * k), int(h * k), Image.INTERPOLATE_LANCZOS)
	img.save_png(a[1])
	if a.size() > 8:
		var maska := Image.create(w, h, false, Image.FORMAT_RGBA8)
		for i in w * h:
			var c := Color(0, 0, 0, 0)
			if ostrovky[i] == 1:
				c = Color(0, 1, 0, 1)
			elif pozadi[i] == 1:
				c = Color(1, 0, 0, 0.35)
			maska.set_pixel(i % w, i / w, c)
		maska.save_png(a[1].get_basename() + "_maska.png")
	print("Uloženo: %s (%d × %d)" % [a[1], img.get_width(), img.get_height()])
	quit()


func _svetle(c: Color, mez: float) -> bool:
	var nej := maxf(c.r, maxf(c.g, c.b))
	var min := minf(c.r, minf(c.g, c.b))
	return min > mez and nej - min < NEUTRALNI


# Mezera ve vlasech je obklopená tmavými prameny: většina pixelů těsně kolem ostrůvku je tmavá
func _tmave_okoli(img: Image, oblast: Array[int]) -> bool:
	var v_oblasti := {}
	for i in oblast:
		v_oblasti[i] = true
	var okoli := 0
	var tmavych := 0
	for i in oblast:
		var x := i % w
		var y := i / w
		for s in [Vector2i(-2, 0), Vector2i(2, 0), Vector2i(0, -2), Vector2i(0, 2)]:
			var nx: int = x + s.x
			var ny: int = y + s.y
			if nx < 0 or ny < 0 or nx >= w or ny >= h:
				continue
			var j := ny * w + nx
			if v_oblasti.has(j):
				continue
			okoli += 1
			if img.get_pixel(nx, ny).get_luminance() < 0.45:
				tmavych += 1
	return okoli > 0 and float(tmavych) / okoli > 0.5


# Oko má uvnitř panenku: ostrůvek, který obklopuje tmavé pixely, není mezera ve vlasech.
# Stačí zkontrolovat, jestli řádek uvnitř ostrůvku (mezi jeho krajními body) prochází tmavým pixelem.
func _obsahuje_tmave(img: Image, oblast: Array[int]) -> bool:
	var radky := {}
	for i in oblast:
		var y := i / w
		var x := i % w
		if not radky.has(y):
			radky[y] = Vector2i(x, x)
		else:
			radky[y] = Vector2i(mini(radky[y].x, x), maxi(radky[y].y, x))
	var tmavych := 0
	for y in radky:
		for x in range(radky[y].x, radky[y].y + 1):
			var c := img.get_pixel(x, y)
			if c.get_luminance() < 0.3:
				tmavych += 1
	return tmavych > 20


func _odbarvi(c: Color) -> Color:
	# Bílá složka -> průhlednost (color to alpha vůči bílé)
	var a := maxf(1.0 - c.r, maxf(1.0 - c.g, 1.0 - c.b))
	a = clampf(a / (1.0 - NEPRUHLEDNE_POD), 0.0, 1.0)
	if a <= 0.001:
		return Color(0, 0, 0, 0)
	return Color(
		clampf((c.r - (1.0 - a)) / a, 0.0, 1.0),
		clampf((c.g - (1.0 - a)) / a, 0.0, 1.0),
		clampf((c.b - (1.0 - a)) / a, 0.0, 1.0),
		a)


# Vzdálenost každého pixelu od nejbližšího pixelu pozadí (v krocích, max. PAS + 1)
func _vzdalenost_od_pozadi(pozadi: PackedByteArray) -> PackedInt32Array:
	var d := PackedInt32Array()
	d.resize(w * h)
	d.fill(PAS + 1)
	var fronta: Array[int] = []
	for i in w * h:
		if pozadi[i] == 1:
			d[i] = 0
			fronta.append(i)
	var hlava := 0
	while hlava < fronta.size():
		var i: int = fronta[hlava]
		hlava += 1
		if d[i] >= PAS:
			continue
		var x := i % w
		var y := i / w
		for s in [Vector2i(-1, 0), Vector2i(1, 0), Vector2i(0, -1), Vector2i(0, 1)]:
			var nx: int = x + s.x
			var ny: int = y + s.y
			if nx < 0 or ny < 0 or nx >= w or ny >= h:
				continue
			var j := ny * w + nx
			if d[j] > d[i] + 1:
				d[j] = d[i] + 1
				fronta.append(j)
	return d


# Vyplní souvislou oblast pixelů splňujících podmínku; vrátí indexy jejích pixelů
func _vypln(img: Image, oznaceno: PackedByteArray, start: Array, podminka: Callable) -> Array[int]:
	var oblast: Array[int] = []
	var zasobnik: Array = start.duplicate()
	while not zasobnik.is_empty():
		var i: int = zasobnik.pop_back()
		if oznaceno[i] == 1 or not podminka.call(img.get_pixel(i % w, i / w)):
			continue
		oznaceno[i] = 1
		oblast.append(i)
		var x := i % w
		var y := i / w
		if x > 0: zasobnik.append(i - 1)
		if x < w - 1: zasobnik.append(i + 1)
		if y > 0: zasobnik.append(i - w)
		if y < h - 1: zasobnik.append(i + w)
	return oblast
