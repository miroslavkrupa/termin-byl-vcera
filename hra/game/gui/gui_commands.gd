# @popochiu-docs-ignore-class
extends SimpleClickCommands


# Výchozí reakce hry: místo anglických systémových hlášek šablony mluví Ruda (texty v tabulce).

# Called when `E.command_fallback()` is triggered.
# By default this checks whether the clicked object is a `PopochiuClickable` or
# a `PopochiuInventoryItem` and invokes the corresponding method based on the
# object type and mouse button.
func fallback() -> void:
	super()


# Called when the player left-clicks a `PopochiuClickable`.
func click_clickable() -> void:
	if I.active:
		await C.player.say("obecne_pouzit_s", [I.active.get_description(), E.clicked.get_description()])
	else:
		await C.player.say("obecne_nelze")


# Called when the player right-clicks a `PopochiuClickable`.
func right_click_clickable() -> void:
	await C.player.say("obecne_nic_k_videni")


# Called when the player left-clicks a `PopochiuInventoryItem`.
func click_inventory_item() -> void:
	if I.active and I.active != I.clicked:
		await C.player.say("obecne_pouzit_s", [I.active.get_description(), I.clicked.get_description()])
	else:
		I.clicked.set_active()


# Called when the player right-clicks a `PopochiuInventoryItem`.
func right_click_inventory_item() -> void:
	await C.player.say("obecne_nic_k_videni")
