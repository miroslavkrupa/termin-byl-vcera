@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCRuda := preload("res://game/characters/ruda/character_ruda.gd")
const PCPanZmena := preload("res://game/characters/pan_zmena/character_pan_zmena.gd")
# ---- classes

# nodes ----
var Ruda: PCRuda : get = get_Ruda
var PanZmena: PCPanZmena : get = get_PanZmena
# ---- nodes

# functions ----
func get_Ruda() -> PCRuda: return get_runtime_character("Ruda")
func get_PanZmena() -> PCPanZmena: return get_runtime_character("PanZmena")
# ---- functions

