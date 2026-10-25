# @popochiu-docs-ignore-class
extends PopochiuRoomData
# Add variables here that should be saved and restored with the room state.
# By default only Godot's built-in types are saved/loaded automatically.
# Use `save_custom` and `load_custom` to handle custom data types.
# Note: `script_name` and `scene` variables inherited from the base class are not saved.

## Ruda už dostal na začátku hrnek kávy
var kava_dana := false
## Pan Změna podepsal svůj požadavek (kap. 1, příznak c1_zmena_dohoda)
var zmena_dohoda := false
## Ruda už byl v archivu (replika u dveří zazní jen poprvé)
var archiv_navstiven := false


#region Virtual ####################################################################################
# Return a Dictionary of custom data to save for this PopochiuRoom.
# The Dictionary must contain only JSON-supported types: bool, int, float, String.
func _on_save() -> Dictionary:
	return {}


# Called when the game is loaded.
# The `data` Dictionary should match the structure returned by `_on_save()`.
func _on_load(data: Dictionary) -> void:
	prints(data)


#endregion
