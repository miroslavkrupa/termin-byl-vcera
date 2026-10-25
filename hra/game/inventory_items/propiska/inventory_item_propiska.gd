# @popochiu-docs-ignore-class
extends PopochiuInventoryItem

const Data := preload('inventory_item_propiska_state.gd')

var state: Data = load("res://game/inventory_items/propiska/inventory_item_propiska.tres")


#region Virtual ####################################################################################
# Called when the item is clicked in the inventory
func _on_click() -> void:
	# Vybere propisku, aby šla použít na něco ve scéně
	set_active()


# Called when the item is right-clicked in the inventory
func _on_right_click() -> void:
	await C.player.say("predmet_propiska_prohlednout")


# Called when the item is middle-clicked in the inventory
func _on_middle_click() -> void:
	# Replace the call to E.command_fallback() to implement your code.
	E.command_fallback()


# Called when the item is clicked while another inventory item is selected
func _on_item_used(item: PopochiuInventoryItem) -> void:
	if item == I.Kava:
		await namocit()
	else:
		E.command_fallback()


# Called when the item is added to the inventory
func _on_added_to_inventory() -> void:
	# Replace the call to `super()` to implement custom behavior.
	# Calling `super()` preserves default behavior as well.
	super()


# Called when the item is discarded from the inventory
func _on_discard() -> void:
	# Replace the call to `super()` to implement custom behavior.
	# Calling `super()` preserves default behavior as well.
	super()


#endregion


#region Public #####################################################################################
## Propiska + káva = kávové pero (kombinace funguje v obou směrech, viz Kava)
func namocit() -> void:
	await C.player.say("ch1_kombinace_pero_1")
	await remove()
	await I.KavovePero.add()
	await C.player.say("ch1_kombinace_pero_2")


#endregion
