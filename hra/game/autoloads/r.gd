@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRNamesti := preload("res://game/rooms/namesti/room_namesti.gd")
const PRArchiv := preload("res://game/rooms/archiv/room_archiv.gd")
# ---- classes

# nodes ----
var Namesti: PRNamesti : get = get_Namesti
var Archiv: PRArchiv : get = get_Archiv
# ---- nodes

# functions ----
func get_Namesti() -> PRNamesti: return get_runtime_room("Namesti")
func get_Archiv() -> PRArchiv: return get_runtime_room("Archiv")
# ---- functions

