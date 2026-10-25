@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIIPropiska := preload("res://game/inventory_items/propiska/inventory_item_propiska.gd")
const PIIKava := preload("res://game/inventory_items/kava/inventory_item_kava.gd")
const PIIKavovePero := preload("res://game/inventory_items/kavove_pero/inventory_item_kavove_pero.gd")
# ---- classes

# nodes ----
var Propiska: PIIPropiska : get = get_Propiska
var Kava: PIIKava : get = get_Kava
var KavovePero: PIIKavovePero : get = get_KavovePero
# ---- nodes

# functions ----
func get_Propiska() -> PIIPropiska: return get_item_instance("Propiska")
func get_Kava() -> PIIKava: return get_item_instance("Kava")
func get_KavovePero() -> PIIKavovePero: return get_item_instance("KavovePero")
# ---- functions

