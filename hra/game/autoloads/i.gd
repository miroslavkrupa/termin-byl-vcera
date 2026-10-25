@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIIPropiska := preload("res://game/inventory_items/propiska/inventory_item_propiska.gd")
# ---- classes

# nodes ----
var Propiska: PIIPropiska : get = get_Propiska
# ---- nodes

# functions ----
func get_Propiska() -> PIIPropiska: return get_item_instance("Propiska")
# ---- functions

