# @popochiu-docs-ignore-class
@tool
extends PopochiuDialog


#region Virtual ####################################################################################
func _on_start() -> void:
	await C.player.face_clicked()
	await C.player.say("ch1_zmena_uvod_ruda")
	await C.PanZmena.say("ch1_zmena_uvod")


func _option_selected(_opt: PopochiuDialogOption) -> void:
	# Každá volba má vlastní funkci _on_option_<id>; Ruda řekne text volby až v ní,
	# aby se repliky nepřekrývaly.
	pass


func _on_option_prodej(opt: PopochiuDialogOption) -> void:
	await D.say_selected()
	# Pan Změna nikdy neprodává dvakrát to samé
	var odpovedi := ["ch1_zmena_prodej_1", "ch1_zmena_prodej_2", "ch1_zmena_001"]
	await C.PanZmena.say(odpovedi[(opt.used_times - 1) % odpovedi.size()])
	await C.player.say("ch1_zmena_prodej_ruda")


func _on_option_propiska(opt: PopochiuDialogOption) -> void:
	await D.say_selected()
	await C.PanZmena.say("ch1_zmena_propiska_1")
	await C.PanZmena.say("ch1_zmena_propiska_2")
	await I.Propiska.add()
	await C.player.say("ch1_zmena_propiska_ruda")
	opt.turn_off_forever()


func _on_option_konec(_opt: PopochiuDialogOption) -> void:
	await D.say_selected()
	await C.PanZmena.say("ch1_zmena_konec")
	stop()


# Return a Dictionary of custom data to save for this PopochiuDialog.
# The Dictionary must contain only JSON-supported types: bool, int, float, String.
func _on_save() -> Dictionary:
	return {}


# Called when the game is loaded.
# The `data` Dictionary should match the structure returned by `_on_save()`.
func _on_load(data: Dictionary) -> void:
	prints(data)


#endregion
