# @popochiu-docs-ignore-class
@tool
extends PopochiuRoom

const Data := preload('room_namesti_state.gd')

var state: Data = load("res://game/rooms/namesti/room_namesti.tres")


#region Virtual ####################################################################################
# Called when Popochiu loads the room. At this point the room is in the scene tree but not yet
# visible.
# Add any code you want to setup the stage before the room is shown to the player (e.g. setting
# character position and facing direction, active walkable area, props visibility, etc.).
func _on_room_entered() -> void:
	if C.player.last_room == "Archiv":
		# Návrat z archivu: Ruda stojí u dveří radnice
		C.player.position = Vector2(950, 748)
		C.player.face_down()
	else:
		# Začátek hry: Ruda stojí vpředu vedle kašny
		C.player.position = Vector2(640, 960)


# Called after the room transition completes; the room is now visible.
# Implement this to start cutscenes, play sounds, etc.
# NOTE: this is NOT called when loading a saved game. Use [_on_restore_from_savegame] for that.
func _on_room_transition_finished() -> void:
	# Ruda začíná s hrnkem kávy (návrh kapitoly 1, Výchozí stav)
	if not state.kava_dana:
		state.kava_dana = true
		await I.Kava.add()


# Called before Popochiu unloads the room.
# At this point the screen is black, processing is disabled, and characters
# have been removed from the $Characters node.
# Implement cleanup code, handle custom data or states before leaving the room, etc. if needed.
func _on_room_exited() -> void:
	pass


# Called after loading a saved game. The state of the room and all its objects is
# completely restored at this point. Use this to resume ongoing events,
# re-establish connections, or restart ambient audio.
# NOTE: `_on_room_transition_finished()` is NOT called when loading a savegame.
# If you need to run its code when loading a savegame, you can call it explicitly from this method.
func _on_restore_from_savegame() -> void:
	pass


#endregion
