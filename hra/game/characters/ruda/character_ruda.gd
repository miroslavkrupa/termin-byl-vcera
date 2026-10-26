# @popochiu-docs-ignore-class
@tool
extends PopochiuCharacter
# You can use `E.queue([])` in any of the methods in this script to trigger a sequence of events.
# Use `await E.queue([])` to pause execution until the sequence completes.

const Data := preload('character_ruda_state.gd')

var state: Data = load("res://game/characters/ruda/character_ruda.tres")

# Pohledy: zepředu (stojí, mluví, jde dopředu), zezadu (jde dozadu) a z boku jako loutka s klouby
# složená z částí (game/characters/spolecne/kostra.gd, části v grafika/postavy/ruda_casti/).
# Chůze dopředu a dozadu: celý obrázek se pohupuje (D36).
const ZEPREDU := preload("res://grafika/postavy/ruda_zepredu.png")
const ZEZADU := preload("res://grafika/postavy/ruda_zezadu.png")
const ZBOKU := preload("res://grafika/postavy/ruda_zboku.png")
const KOSTRA := preload("res://game/characters/spolecne/kostra.gd")
const CASTI := "res://grafika/postavy/ruda_casti/%s.png"
## Kreslené fáze chůze bokem (D40); když existují, mají přednost před loutkou s klouby
const FAZE_BOK := "res://grafika/postavy/ruda_chuze_bok/faze_%02d.png"
## Výška postavy v souřadnicích postavy (stejná jako obrázek zepředu)
const VYSKA := 988.0
## Popis fází z nástroje sestav_faze.gd: o kolik se mezi fázemi posune noha na zemi
const FAZE_BOK_POPIS := "res://grafika/postavy/ruda_chuze_bok/faze.json"

## Části postavy a body kloubů v pixelech obrázků (z listu docs/styl/vzorky/ruda-casti_v01.png)
const POPIS := {
	meritko = 0.567,
	ruka_zadni = "predlokti_hrnek",
	ruka_predni = "predlokti_desky",
	casti = {
		hlava = {krk = Vector2(240, 545)},
		trup = {krk = Vector2(122, 32), rameno = Vector2(42, 150), kycel = Vector2(140, 455)},
		paze = {rameno = Vector2(85, 45), loket = Vector2(125, 355)},
		predlokti_hrnek = {loket = Vector2(35, 65)},
		predlokti_desky = {loket = Vector2(35, 140)},
		stehno = {kycel = Vector2(75, 30), koleno = Vector2(110, 355)},
		lytko = {koleno = Vector2(55, 30), kotnik = Vector2(55, 345)},
		bota = {kotnik = Vector2(65, 30)},
	},
}

var _chodi := false
var _bokem := false
var _posledni_pozice := Vector2.ZERO
var _kostra: Node2D
var _faze_bok: Array[Texture2D] = []
var _posuny_bok: Array[float] = []   # posun nohy na zemi za každou fázi, v souřadnicích postavy
var _vyska_stani := VYSKA            # výška obrázků stání, aby byl Ruda stejně velký jako při chůzi
var _faze := 0                       # zobrazená fáze
var _usla_ve_fazi := 0.0             # kolik už postava ušla od začátku zobrazené fáze
var _smer_chuze := Vector2.RIGHT


#region Virtual ####################################################################################
# Called when the room where this character is located has finished being added to the scene tree.
func _on_room_set() -> void:
	_postav_kostru()


# Called when the character is clicked
func _on_click() -> void:
	# Replace the call to E.command_fallback() with your own logic.
	E.command_fallback()
	# Example: make the player walk to this character, face them, then say a line.
#	await C.player.walk_to_clicked()
#	await C.player.face_clicked()
#	await C.player.say("Hi!")


# Called when the character is double-clicked
func _on_double_click() -> void:
	# Replace the call to E.command_fallback() with your code.
	E.command_fallback()
	# Example: teleport the player to the character.
#	C.player.teleport_to_character(self)


# Called when the character is right-clicked
func _on_right_click() -> void:
	# Replace the call to E.command_fallback() with your own logic.
	E.command_fallback()
	# Example: make the player face the character and describe them.
#	await C.player.face_clicked()
#	await C.player.say("Mmmh, dude looks rad...")


# Called when the character is middle clicked
func _on_middle_click() -> void:
	# Replace the call to E.command_fallback() to implement your code.
	E.command_fallback()
	# Example: make the player say something without facing the character.
#	await C.player.say("I don't want to talk to this guy")


# Called when the character is clicked while an inventory item is selected
func _on_item_used(_item: PopochiuInventoryItem) -> void:
	# Replace the call to E.command_fallback() with your own logic.
	E.command_fallback()
	# Example: if the player uses a Key on this character, make the player say something.
#	if _item == I.Key:
#		await C.player.say("I don't want to give my key away!")


# Override this to alter the idle animation or hook custom logic to it. 
# By default, it plays the "idle" animation from the character's Sprite.
func _play_idle() -> void:
	_chodi = false
	# Po chůzi do strany zůstane stát bokem a čelem po směru chůze, jinak zepředu
	if _bokem:
		_pohled(ZBOKU, _smer_chuze.x < 0)
		$Sprite2D.flip_h = _smer_chuze.x < 0
	else:
		_pohled(ZEPREDU, false)


# Override this to alter the walk animation or hook custom logic to it. 
# `target_pos` can be used to determine the movement direction.
# By default, it plays the "walk" animation from the character's Sprite.
func _play_walk(target_pos: Vector2) -> void:
	_chodi = true
	_posledni_pozice = position
	var smer := target_pos - position
	# Bokem, kdykoli jde aspoň trochu do strany; zepředu nebo zezadu jen při chůzi skoro svisle
	_bokem = absf(smer.x) > absf(smer.y) * 0.3
	if smer != Vector2.ZERO:
		_smer_chuze = smer.normalized()
	_pohled(ZEZADU if smer.y < 0 else ZEPREDU, smer.x < 0)


# Override this to alter the talk animation or hook custom logic to it.
# By default, it plays the "talk" animation from the character's Sprite.
func _play_talk() -> void:
	_chodi = false
	_bokem = false
	_pohled(ZEPREDU, false)


# Override this to alter the grab animation or hook custom logic to it.
# By default, it plays the "grab" animation from the character's Sprite.
func _play_grab() -> void:
	_chodi = false
	_pohled(ZEPREDU, false)


# Called when the character starts moving.
# Implement any logic you want to trigger at the start of movement here.
# For example, you could play a sound effect or make something happen in the room.
func _on_movement_started() -> void:
	pass


# Called when the character stops moving
# Implement any logic you want to trigger at the start of movement here.
# For example, you could play a sound effect or make something happen in the room.
func _on_movement_ended() -> void:
	pass


# Called when this character's movement is blocked by a region with walkable = false.
# Override to react to the event: play a sound, show a hint, trigger dialogue, etc.
# `_region` is the PopochiuRegion that stopped the character.
func _on_blocked_by_region(_region: PopochiuRegion) -> void:
	pass


#endregion

#region Public #####################################################################################
# Add functions here that are triggered by GUI commands.
#
# If you name the functions following the `on_<command_id>` pattern, they will be automatically
# called when the corresponding command is triggered in the GUI.
#
# For example, if your GUI provides a `look_at` command you could add:
#
#func on_look_at() -> void:
#	pass
#
# This function will be called whenever the `look_at` command is triggered in the GUI while this
# character is the target.
# This keeps the code way more tidy and organized with GUIs with many different commands,
# as opposed to having a single `match` statement in the general-use methods.


#endregion


#region Private ####################################################################################
func _pohled(obrazek: Texture2D, doleva: bool) -> void:
	_postav_kostru()
	var kostra := _chodi and _bokem and _faze_bok.is_empty()
	# Fáze chůze jsou kreslené doprava, doleva se zrcadlí; pohledy zepředu a zezadu se nezrcadlí
	$Sprite2D.flip_h = doleva and _chodi and _bokem
	_kostra.visible = kostra
	_kostra.scale.x = absf(_kostra.scale.x) * (-1.0 if doleva else 1.0)
	$Sprite2D.visible = not kostra
	if not _chodi or not _bokem or _faze_bok.is_empty():
		_nastav_obrazek(obrazek)
	if not _chodi:
		$Sprite2D.position = Vector2.ZERO
		$Stin.position = Vector2.ZERO
		$Sprite2D.rotation = 0.0
		_usla_ve_fazi = 0.0


# Obrázek postavy ve správné výšce bez ohledu na rozlišení (fáze chůze jsou menší než pohledy).
# Fáze chůze mají společné plátno, škáluje se celé; pohledy stání se škálují podle postavy.
func _nastav_obrazek(obrazek: Texture2D) -> void:
	$Sprite2D.texture = obrazek
	var k := (VYSKA if obrazek in _faze_bok else _vyska_stani) / obrazek.get_height()
	$Sprite2D.scale = Vector2(k, k)
	$Sprite2D.offset = Vector2(0, -obrazek.get_height() / 2.0)


func _postav_kostru() -> void:
	if _kostra:
		return
	var popis: Dictionary = POPIS.duplicate(true)
	for nazev in popis.casti:
		popis.casti[nazev].obrazek = load(CASTI % nazev)
	var i := 1
	while ResourceLoader.exists(FAZE_BOK % i):
		_faze_bok.append(load(FAZE_BOK % i))
		i += 1
	if not _faze_bok.is_empty():
		var popis_faze: Dictionary = JSON.parse_string(FileAccess.get_file_as_string(FAZE_BOK_POPIS))
		for posun in popis_faze.posuny:
			_posuny_bok.append(posun * VYSKA / popis_faze.vyska)
		# Stání má stejnou výšku jako průměrná fáze chůze (ne jako nejvyšší), jinak Ruda po zastavení „vyroste“
		_vyska_stani = VYSKA * popis_faze.vyska_prumer / popis_faze.vyska
	_kostra = KOSTRA.new()
	_kostra.name = "Kostra"
	_kostra.visible = false
	add_child(_kostra)
	move_child(_kostra, $Sprite2D.get_index())
	_kostra.sestav(popis)


# Fáze kroku se posouvá podle ušlé vzdálenosti, takže nohy neklouzají ani při zmenšení do hloubky.
# Pozor: Popochiu postavám vypíná _process (zapíná ho jen při sledování jiné postavy), proto se
# animace počítá v _physics_process, kde Popochiu postavu i posouvá.
func _physics_process(delta: float) -> void:
	super(delta)
	if Engine.is_editor_hint() or not _kostra:
		return
	var pohyb := position - _posledni_pozice
	var usla := pohyb.length() / maxf(scale.x, 0.01)
	_posledni_pozice = position
	if _kostra.visible:
		_kostra.posun(usla / _kostra.scale.y, _chodi, delta)
	elif _chodi and _bokem and not _faze_bok.is_empty():
		# Další fáze přijde, až postava ujde tolik, o kolik se ve fázi posune noha na zemi.
		# Chodidlo tak stojí na místě a neklouže.
		_usla_ve_fazi += usla
		while _usla_ve_fazi >= _posuny_bok[_faze]:
			_usla_ve_fazi -= _posuny_bok[_faze]
			_faze = (_faze + 1) % _faze_bok.size()
		_nastav_obrazek(_faze_bok[_faze])
		# Obrázek se během fáze nehýbe a poskočí až s další fází, o krok stojící nohy.
		# Jinak by se celá postava i s nohou na zemi plynule posouvala a noha by klouzala.
		if usla > 0.0:
			_smer_chuze = pohyb.normalized()
		$Sprite2D.position = -_smer_chuze * _usla_ve_fazi
		$Stin.position = $Sprite2D.position
	elif _chodi:
		# Dopředu a dozadu (dočasně, než budou kreslené fáze): jen jemné pohupování v rytmu kroků,
		# bez kývání do stran, které působilo směšně
		var f := fmod(Time.get_ticks_msec() / 1000.0 * 8.0, TAU)
		$Sprite2D.position.y = -absf(sin(f)) * 10.0


#endregion
