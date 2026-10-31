# Zakládá objekty Popochiu bez editoru, stejnými továrnami jako panel Popochiu v editoru.
# Spuštění: godot --headless --path hra -- vytvor <příkaz> <argumenty>
# Běží uvnitř hry (spouští ho nastroje/ladeni.gd), protože skripty hry používají globální
# objekty Popochiu (C, E, R, I…), které existují jen ve spuštěné hře.
#
# Příkazy:
#   mistnost <Nazev> [hlavni]                        místnost; „hlavni“ = spouští se jako první
#   postava <Nazev> [hrac]                           postava; „hrac“ = ovládá ji hráč
#   predmet <Nazev>                                  předmět do inventáře
#   dialog <Nazev> <id:klic> [<id:klic> …]           dialog s volbami (klic = ID textu volby v tabulce)
#   postava_do <Mistnost> <Postava> <x,y>            umístí postavu do místnosti
#   pochozi <Mistnost> <Nazev> "<x,y x,y …>"         pochozí plocha s obrysem (souřadnice místnosti)
#   pochozi_obrys <Mistnost> <Nazev> "<x,y x,y …>"   nový obrys existující pochozí plochy (překážky
#                                                    uvnitř, např. kašnu, vykrojí Popochiu z kulis s obstacle)
#   aktivni <Mistnost> <Nazev> "<x,y x,y …>" <x,y>   aktivní místo s obrysem a bodem, kam postava dojde
#   kulisa <Mistnost> <Nazev> <res://obrázek.png> [x,y]   neinteraktivní obrázek (název Background = pozadí)
#   oblast <Mistnost> <Nazev> "<x,y x,y …>" [nahore dole]  oblast; s měřítky zmenšuje postavy do hloubky
#
# Po založení objektu je dobré otevřít projekt v editoru, aby se obnovil panel Popochiu.
extends RefCounted

# Továrny Popochiu vracejí při úspěchu ResultCodes.SUCCESS (1), ne OK (0)
const USPECH := ResultCodes.SUCCESS


## Provede příkaz; vrací true při úspěchu.
func spust(a: PackedStringArray) -> bool:
	if a.size() < 2:
		push_error("Chybí příkaz. Viz hlavička skriptu.")
		return false
	var vysledek := USPECH
	match a[0]:
		"mistnost":
			vysledek = _mistnost(a[1], a.size() > 2 and a[2] == "hlavni")
		"postava":
			vysledek = _postava(a[1], a.size() > 2 and a[2] == "hrac")
		"predmet":
			vysledek = _predmet(a[1])
		"dialog":
			vysledek = _dialog(a[1], a.slice(2))
		"postava_do":
			vysledek = _postava_do(a[1], a[2], _bod(a[3]))
		"pochozi":
			vysledek = _pochozi(a[1], a[2], _body(a[3]))
		"pochozi_obrys":
			vysledek = _pochozi_obrys(a[1], a[2], _body(a[3]))
		"aktivni":
			vysledek = _aktivni(a[1], a[2], _body(a[3]), _bod(a[4]))
		"oblast":
			vysledek = _oblast(a[1], a[2], _body(a[3]), float(a[4]) if a.size() > 5 else -1.0, float(a[5]) if a.size() > 5 else -1.0)
		"kulisa":
			vysledek = _kulisa(a[1], a[2], a[3], _bod(a[4]) if a.size() > 4 else Vector2(-1, -1))
		_:
			push_error("Neznámý příkaz: %s" % a[0])
			return false
	if vysledek != USPECH:
		push_error("Nepodařilo se (kód %d)." % vysledek)
		return false
	print("Hotovo: %s %s" % [a[0], a[1]])
	return true


func _mistnost(nazev: String, hlavni: bool) -> int:
	var f := PopochiuRoomFactory.new()
	var r := _hlavni_objekt(f, nazev)
	if r != USPECH:
		return r
	var obj: PopochiuRoom = f._load_obj_base_scene()
	obj.name = "Room" + f._pascal_name
	obj.script_name = f._pascal_name
	obj.width = ProjectSettings.get_setting(PopochiuResources.DISPLAY_WIDTH)
	obj.height = ProjectSettings.get_setting(PopochiuResources.DISPLAY_HEIGHT)
	r = f._save_obj_scene(obj)
	if r != USPECH:
		return r
	_registrovat(f)
	if hlavni:
		ProjectSettings.set_setting(PopochiuResources.MAIN_SCENE, f._path_scene)
		ProjectSettings.save()
	return USPECH


func _postava(nazev: String, hrac: bool) -> int:
	var f := PopochiuCharacterFactory.new()
	var r := _hlavni_objekt(f, nazev)
	if r != USPECH:
		return r
	var obj: PopochiuCharacter = f._load_obj_base_scene()
	obj.name = "Character" + f._pascal_name
	obj.script_name = f._pascal_name
	obj.description = f._pascal_name.capitalize()
	obj.cursor = PopochiuResources.CURSOR_TYPE.TALK
	r = f._save_obj_scene(obj)
	if r != USPECH:
		return r
	_registrovat(f)
	if hrac:
		PopochiuResources.set_data_value("setup", "pc", f._pascal_name)
	return USPECH


func _predmet(nazev: String) -> int:
	var f := PopochiuInventoryItemFactory.new()
	var r := _hlavni_objekt(f, nazev)
	if r != USPECH:
		return r
	var obj: PopochiuInventoryItem = f._load_obj_base_scene()
	obj.name = "Item" + f._pascal_name
	obj.script_name = f._pascal_name
	obj.description = f._pascal_name.capitalize()
	obj.cursor = PopochiuResources.CURSOR_TYPE.USE
	obj.size_flags_vertical = obj.SIZE_SHRINK_CENTER
	r = f._save_obj_scene(obj)
	if r != USPECH:
		return r
	_registrovat(f)
	return USPECH


func _dialog(nazev: String, volby: PackedStringArray) -> int:
	# Kroky továrny PopochiuDialogFactory.create() bez části, která potřebuje editor
	var f := PopochiuDialogFactory.new()
	f._setup_name(nazev)
	var r: int = f._create_obj_folder()
	if r != USPECH:
		return r
	r = f._copy_script_template()
	if r != USPECH:
		return r
	var dialog := PopochiuDialog.new()
	dialog.set_script(load(f._path_script))
	dialog.script_name = f._pascal_name
	dialog.resource_name = f._pascal_name
	var seznam: Array[PopochiuDialogOption] = []
	for v in volby:
		var c := v.split(":")
		var volba := PopochiuDialogOption.new()
		volba.id = c[0]
		volba.text = c[1]
		seznam.append(volba)
	dialog.options = seznam
	r = f._save_obj_resource(dialog)
	if r != USPECH:
		return r
	_registrovat(f)
	return USPECH


func _postava_do(mistnost: String, postava: String, kde: Vector2) -> int:
	var room := _nacti_mistnost(mistnost)
	if room == null:
		return ResultCodes.FAILURE
	var snake := postava.to_snake_case()
	var cesta := PopochiuResources.CHARACTERS_PATH.path_join("%s/character_%s.tscn" % [snake, snake])
	if not FileAccess.file_exists(cesta):
		push_error("Postava %s neexistuje (%s)" % [postava, cesta])
		return ResultCodes.FAILURE
	var chr: Node2D = (load(cesta) as PackedScene).instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	chr.position = kde
	room.get_node("Characters").add_child(chr)
	chr.owner = room
	var balik := PackedScene.new()
	if balik.pack(room) != OK or ResourceSaver.save(balik, room.scene_file_path) != OK:
		return ResultCodes.ERR_CANT_SAVE_OBJ_SCENE
	return USPECH


func _pochozi(mistnost: String, nazev: String, obrys: PackedVector2Array) -> int:
	var room := _nacti_mistnost(mistnost)
	if room == null:
		return ResultCodes.FAILURE
	# Kroky továrny PopochiuWalkableAreaFactory.create() bez čtení nastavení editoru
	var f := PopochiuWalkableAreaFactory.new()
	f._setup_room(room)
	f._setup_name(nazev)
	var r: int = f._create_obj_folder()
	if r != USPECH:
		return r
	r = f._copy_script_template()
	if r != USPECH:
		return r
	var obj: PopochiuWalkableArea = f._load_obj_base_scene()
	obj.set_script(ResourceLoader.load(f._path_script))
	obj.name = f._pascal_name
	obj.script_name = f._pascal_name
	obj.description = f._snake_name.capitalize()
	var obrysy: Array[PackedVector2Array] = [obrys]
	obj.interaction_polygon = obrysy
	# Navigační polygon musí existovat, jinak ho PopochiuWalkableArea za běhu nenačte
	var navpoly := NavigationPolygon.new()
	navpoly.agent_radius = 0.0
	navpoly.add_outline(obrys)
	NavigationServer2D.bake_from_source_geometry_data(navpoly, NavigationMeshSourceGeometryData2D.new())
	obj.find_child("Perimeter").navigation_polygon = navpoly
	r = f._save_obj_scene(obj)
	if r != USPECH:
		return r
	return _pridat_do_mistnosti(room, f, obj)


func _pochozi_obrys(mistnost: String, nazev: String, obrys: PackedVector2Array) -> int:
	var cesta := "res://game/rooms/%s/walkable_areas/%s/walkable_area_%s.tscn" % [mistnost.to_snake_case(), nazev.to_snake_case(), nazev.to_snake_case()]
	if not ResourceLoader.exists(cesta):
		push_error("Pochozí plocha nenalezena: " + cesta)
		return ResultCodes.FAILURE
	var obj: PopochiuWalkableArea = load(cesta).instantiate()
	var obrysy: Array[PackedVector2Array] = [obrys]
	obj.interaction_polygon = obrysy
	var navpoly := NavigationPolygon.new()
	navpoly.agent_radius = 0.0
	navpoly.add_outline(obrys)
	NavigationServer2D.bake_from_source_geometry_data(navpoly, NavigationMeshSourceGeometryData2D.new())
	obj.find_child("Perimeter").navigation_polygon = navpoly
	var scena := PackedScene.new()
	var r := scena.pack(obj)
	if r == OK:
		r = ResourceSaver.save(scena, cesta)
	obj.free()
	return USPECH if r == OK else ResultCodes.FAILURE


func _aktivni(mistnost: String, nazev: String, obrys: PackedVector2Array, kam: Vector2) -> int:
	var room := _nacti_mistnost(mistnost)
	if room == null:
		return ResultCodes.FAILURE
	var f := PopochiuHotspotFactory.new()
	var p := PopochiuHotspotFactory.PopochiuHotspotFactoryParam.new()
	p.room = room
	p.obj_name = nazev
	p.should_add_to_room = false
	p.interaction_polygon = obrys
	var r: int = f.create(p)
	if r != USPECH:
		return r
	var obj: PopochiuHotspot = f.get_obj_scene()
	obj.walk_to_point = kam
	return _pridat_do_mistnosti(room, f, obj)


func _kulisa(mistnost: String, nazev: String, obrazek: String, kde: Vector2) -> int:
	var room := _nacti_mistnost(mistnost)
	if room == null:
		return ResultCodes.FAILURE
	var f := PopochiuPropFactory.new()
	var p := PopochiuPropFactory.PopochiuPropFactoryParam.new()
	p.room = room
	p.obj_name = nazev
	p.should_add_to_room = false
	p.is_interactive = false
	var r: int = f.create(p)
	if r != USPECH:
		return r
	var obj: PopochiuProp = f.get_obj_scene()
	obj.texture = load(obrazek)
	if kde.x < 0:
		kde = Vector2(room.width, room.height) / 2.0
	obj.position = kde
	return _pridat_do_mistnosti(room, f, obj)


func _oblast(mistnost: String, nazev: String, obrys: PackedVector2Array, nahore: float, dole: float) -> int:
	var room := _nacti_mistnost(mistnost)
	if room == null:
		return ResultCodes.FAILURE
	var f := PopochiuRegionFactory.new()
	var p := PopochiuRegionFactory.PopochiuRegionFactoryParam.new()
	p.room = room
	p.obj_name = nazev
	p.should_add_to_room = false
	p.interaction_polygon = obrys
	var r: int = f.create(p)
	if r != USPECH:
		return r
	var obj: PopochiuRegion = f.get_obj_scene()
	if nahore > 0:
		obj.scaling = true
		obj.scale_top = nahore
		obj.scale_bottom = dole
	return _pridat_do_mistnosti(room, f, obj)


# Společné kroky pro místnost, postavu a předmět (bez části, která potřebuje editor)
func _hlavni_objekt(f, nazev: String) -> int:
	f._setup_name(nazev)
	var r: int = f._create_obj_folder()
	if r != USPECH:
		return r
	r = f._create_state_resource()
	if r != USPECH:
		return r
	return _skript_ze_sablony(f)


# Stejné jako továrna Popochiu (_create_script_from_template), jen zatím bez náhrady
# „PopochiuUtils.e“ → „E“: globální E bez editoru neexistuje a skript by nešel přeložit.
# Náhradu doplní _registrovat() po uložení scény.
func _skript_ze_sablony(f) -> int:
	var kod := FileAccess.get_file_as_string(f.BASE_SCRIPT_TEMPLATE % f._type_label)
	if kod.is_empty():
		return ResultCodes.ERR_CANT_OPEN_OBJ_SCRIPT_TEMPLATE
	kod = kod.replace("%s_state_template" % f._type_label, "%s_%s_state" % [f._type_label, f._snake_name])
	kod = kod.replace("Data = null", 'Data = load("%s.tres")' % f._path_base)
	f._script = load(f.EMPTY_SCRIPT).duplicate()
	f._script.source_code = kod
	if ResourceSaver.save(f._script, f._path_script) != OK:
		return ResultCodes.ERR_CANT_CREATE_OBJ_SCRIPT
	return USPECH


func _registrovat(f) -> void:
	var res := ResourceLoader.load(f._path_resource)
	PopochiuResources.set_data_value(f._type_target, res.script_name, res.resource_path)
	PopochiuResources.update_autoloads(true)
	f._register_in_pot_files()
	var kod := FileAccess.get_file_as_string(f._path_script)
	var soubor := FileAccess.open(f._path_script, FileAccess.WRITE)
	soubor.store_string(kod.replace("PopochiuUtils.e", "E"))
	soubor.close()


func _nacti_mistnost(nazev: String) -> PopochiuRoom:
	var snake := nazev.to_snake_case()
	var cesta := PopochiuResources.ROOMS_PATH.path_join("%s/room_%s.tscn" % [snake, snake])
	if not FileAccess.file_exists(cesta):
		push_error("Místnost %s neexistuje (%s)" % [nazev, cesta])
		return null
	return (load(cesta) as PackedScene).instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)


# Náhrada za _add_resource_to_room(), které ukládá scénu přes editor
func _pridat_do_mistnosti(room: PopochiuRoom, f, obj: Node) -> int:
	var kopie: Node = (load(f._path_scene) as PackedScene).instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	if obj is PopochiuHotspot:
		kopie.walk_to_point = obj.walk_to_point
	elif obj is PopochiuRegion:
		kopie.interaction_polygon = obj.interaction_polygon
		kopie.scaling = obj.scaling
		kopie.scale_top = obj.scale_top
		kopie.scale_bottom = obj.scale_bottom
	elif obj is PopochiuProp:
		kopie.texture = obj.texture
		kopie.position = obj.position
	room.get_node(f._obj_room_group).add_child(kopie)
	kopie.owner = room
	for dite in kopie.get_children():
		if dite.has_meta(PopochiuRoomObjFactory.CHILD_VISIBLE_IN_ROOM_META):
			dite.owner = room
			dite.remove_meta(PopochiuRoomObjFactory.CHILD_VISIBLE_IN_ROOM_META)
	f._register_in_pot_files()
	var balik := PackedScene.new()
	if balik.pack(room) != OK:
		return ResultCodes.ERR_CANT_SAVE_OBJ_SCENE
	if ResourceSaver.save(balik, room.scene_file_path) != OK:
		return ResultCodes.ERR_CANT_SAVE_OBJ_SCENE
	return USPECH


func _body(text: String) -> PackedVector2Array:
	var vysledek := PackedVector2Array()
	for dvojice in text.strip_edges().split(" ", false):
		vysledek.append(_bod(dvojice))
	return vysledek


func _bod(text: String) -> Vector2:
	var c := text.split(",")
	return Vector2(float(c[0]), float(c[1]))

