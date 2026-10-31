# Záběr kamery u místností na jednu obrazovku (F0/R1): pozadí je širší než základní rozlišení
# (19,5:9 proti 3:2) a důležitý obsah leží v pásu 3:2 uprostřed. Kamera stojí uprostřed místnosti
# a na širší obrazovce ukáže víc z okrajů pozadí, místo šedých pruhů. Bez tohohle by kamera
# Popochiu jezdila za hráčem, jakmile je pozadí širší než obrazovka.
# Místnosti širší než obrazovka (posuvné, width > 1536) řídí kamera Popochiu jako dřív.
extends Node

const ZAKLAD := Vector2(1536, 1024)


func _ready() -> void:
	# Za okrajem pozadí (obrazovka širší než 19,5:9) je černá, ne šedá
	RenderingServer.set_default_clear_color(Color.BLACK)


func _process(_delta: float) -> void:
	var r = get_node("/root/R")
	var e = get_node("/root/E")
	if not is_instance_valid(r.current) or r.current.width > ZAKLAD.x or not is_instance_valid(e.camera):
		return
	var viditelne := get_viewport().get_visible_rect().size
	var stred := ZAKLAD / 2.0
	# Meze přesně o velikosti obrazovky: kamera nemá kam ujet a záběr zůstane uprostřed
	e.camera.limit_left = int(stred.x - viditelne.x / 2.0)
	e.camera.limit_right = int(stred.x + viditelne.x / 2.0)
	e.camera.limit_top = int(stred.y - viditelne.y / 2.0)
	e.camera.limit_bottom = int(stred.y + viditelne.y / 2.0)
