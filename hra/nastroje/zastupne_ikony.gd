# Nakreslí zástupné ikony předmětů pro prototyp (128 × 128, průhledné pozadí, linka v barvě stylové bible).
# Finální ikony nahradí AI grafika. Spuštění: godot --headless --path hra --script res://nastroje/zastupne_ikony.gd
extends SceneTree

const LINKA := Color(0.18, 0.12, 0.08)
const KREM := Color(0.95, 0.9, 0.78)
const KAVA := Color(0.42, 0.24, 0.12)
const CERVENA := Color(0.71, 0.27, 0.17)
const SEDA := Color(0.62, 0.62, 0.6)
const OBRYS := 4.0


func _init() -> void:
	_uloz(_propiska(false), "res://grafika/predmety/propiska.png")
	_uloz(_propiska(true), "res://grafika/predmety/kavove_pero.png")
	_uloz(_hrnek(), "res://grafika/predmety/kava.png")
	quit()


func _propiska(kavova: bool) -> Image:
	var img := _nova()
	var spicka := Vector2(24, 104)
	var konec := Vector2(104, 24)
	# Obrys celé propisky, pak výplně jednotlivých částí
	_kapsle(img, spicka.lerp(konec, 0.1), konec, 11 + OBRYS, LINKA)
	_kapsle(img, spicka, spicka.lerp(konec, 0.12), 6 + OBRYS, LINKA)
	_kapsle(img, spicka.lerp(konec, 0.12), konec, 11, KREM)
	_kapsle(img, spicka.lerp(konec, 0.8), konec, 11, CERVENA)
	_kapsle(img, spicka, spicka.lerp(konec, 0.12), 6, KAVA if kavova else SEDA)
	if kavova:
		# Kapka kávy pod hrotem
		_kruh(img, Vector2(18, 118), 6 + OBRYS, LINKA)
		_kruh(img, Vector2(18, 118), 6, KAVA)
	return img


func _hrnek() -> Image:
	var img := _nova()
	# Ucho, tělo, káva nahoře, pára
	_prstenec(img, Vector2(92, 66), 20, 9 + OBRYS, LINKA)
	_prstenec(img, Vector2(92, 66), 20, 9, KREM)
	_obdelnik(img, Rect2(24 - OBRYS, 34 - OBRYS, 64 + 2 * OBRYS, 76 + 2 * OBRYS), LINKA)
	_obdelnik(img, Rect2(24, 34, 64, 76), KREM)
	_obdelnik(img, Rect2(24, 34, 64, 12), KAVA)
	for x in [40, 58, 76]:
		_kapsle(img, Vector2(x, 26), Vector2(x - 4, 10), 2.5, LINKA)
	return img


func _nova() -> Image:
	var img := Image.create(128, 128, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	return img


func _kapsle(img: Image, a: Vector2, b: Vector2, r: float, c: Color) -> void:
	for x in img.get_width():
		for y in img.get_height():
			var p := Vector2(x, y)
			var t := clampf((p - a).dot(b - a) / (b - a).length_squared(), 0.0, 1.0)
			if p.distance_to(a.lerp(b, t)) <= r:
				img.set_pixel(x, y, c)


func _kruh(img: Image, s: Vector2, r: float, c: Color) -> void:
	_kapsle(img, s, s + Vector2(0.01, 0), r, c)


func _prstenec(img: Image, s: Vector2, r: float, tloustka: float, c: Color) -> void:
	for x in img.get_width():
		for y in img.get_height():
			if absf(Vector2(x, y).distance_to(s) - r) <= tloustka / 2.0:
				img.set_pixel(x, y, c)


func _obdelnik(img: Image, rect: Rect2, c: Color) -> void:
	img.fill_rect(Rect2i(rect), c)


func _uloz(img: Image, cesta: String) -> void:
	img.save_png(ProjectSettings.globalize_path(cesta))
	print("Uloženo: ", cesta)
