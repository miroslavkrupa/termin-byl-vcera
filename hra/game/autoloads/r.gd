@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRNamesti := preload("res://game/rooms/namesti/room_namesti.gd")
# ---- classes

# nodes ----
var Namesti: PRNamesti : get = get_Namesti
# ---- nodes

# functions ----
func get_Namesti() -> PRNamesti: return get_runtime_room("Namesti")
# ---- functions

