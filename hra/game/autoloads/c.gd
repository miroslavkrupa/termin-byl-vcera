@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCRuda := preload("res://game/characters/ruda/character_ruda.gd")
# ---- classes

# nodes ----
var Ruda: PCRuda : get = get_Ruda
# ---- nodes

# functions ----
func get_Ruda() -> PCRuda: return get_runtime_character("Ruda")
# ---- functions

