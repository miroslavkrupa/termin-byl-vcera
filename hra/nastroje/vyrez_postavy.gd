# Vyřízne postavu z referenčního listu a odstraní bílé pozadí.
# Spuštění: godot --headless --path hra --script res://nastroje/vyrez_postavy.gd -- <vstup.png> <výstup.png> <x> <y> <šířka> <výška>
extends SceneTree

const BILA := 0.91         # pozadí listu: všechny kanály nad touto hodnotou
const CISTE_BILA := 0.972  # uzavřené bílé ostrůvky (např. mezi nohama)
const MIN_OSTROVEK := 200  # menší ostrůvky jsou odlesky v kresbě, ty zůstanou


func _init() -> void:
	var a := OS.get_cmdline_user_args()
	if a.size() != 6:
		push_error("Použití: -- <vstup.png> <výstup.png> <x> <y> <šířka> <výška>")
		quit(1)
		return
	var zdroj := Image.load_from_file(a[0])
	var vyrez := zdroj.get_region(Rect2i(int(a[2]), int(a[3]), int(a[4]), int(a[5])))
	vyrez.convert(Image.FORMAT_RGBA8)
	var w := vyrez.get_width()
	var h := vyrez.get_height()
	var odstraneno := PackedByteArray()
	odstraneno.resize(w * h)

	# 1) výplň od okrajů výřezu
	var zasobnik: Array[int] = []
	for x in w:
		zasobnik.append(x)
		zasobnik.append((h - 1) * w + x)
	for y in h:
		zasobnik.append(y * w)
		zasobnik.append(y * w + w - 1)
	_vypln(vyrez, odstraneno, zasobnik, BILA, w, h, -1)

	# 2) uzavřené čistě bílé ostrůvky větší než MIN_OSTROVEK
	var navstiveno := odstraneno.duplicate()
	for i in w * h:
		if navstiveno[i] == 0 and _je_bila(vyrez, i, w, CISTE_BILA):
			var oblast := _vypln(vyrez, navstiveno, [i], CISTE_BILA, w, h, 0)
			if oblast.size() > MIN_OSTROVEK:
				for j in oblast:
					odstraneno[j] = 1

	for i in w * h:
		if odstraneno[i] == 1:
			vyrez.set_pixel(i % w, i / w, Color(0, 0, 0, 0))
	vyrez.save_png(a[1])
	print("Uloženo: %s (%d × %d)" % [a[1], w, h])
	quit()


func _je_bila(img: Image, i: int, w: int, prah: float) -> bool:
	var c := img.get_pixel(i % w, i / w)
	return c.r > prah and c.g > prah and c.b > prah


# Vyplní souvislou bílou oblast; vrátí indexy jejích pixelů (jen když sber >= 0)
func _vypln(img: Image, oznaceno: PackedByteArray, start: Array, prah: float, w: int, h: int, sber: int) -> Array[int]:
	var oblast: Array[int] = []
	var zasobnik: Array = start.duplicate()
	while not zasobnik.is_empty():
		var i: int = zasobnik.pop_back()
		if oznaceno[i] == 1 or not _je_bila(img, i, w, prah):
			continue
		oznaceno[i] = 1
		if sber >= 0:
			oblast.append(i)
		var x := i % w
		var y := i / w
		if x > 0: zasobnik.append(i - 1)
		if x < w - 1: zasobnik.append(i + 1)
		if y > 0: zasobnik.append(i - w)
		if y < h - 1: zasobnik.append(i + w)
	return oblast
