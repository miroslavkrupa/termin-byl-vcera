@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDPanZmena := preload("res://game/dialogs/pan_zmena/dialog_pan_zmena.gd")
# ---- classes

# nodes ----
var PanZmena: PDPanZmena : get = get_PanZmena
# ---- nodes

# functions ----
func get_PanZmena() -> PDPanZmena: return get_instance("PanZmena")
# ---- functions

