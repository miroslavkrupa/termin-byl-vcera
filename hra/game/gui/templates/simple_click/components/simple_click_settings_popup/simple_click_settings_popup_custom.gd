@tool
extends "simple_click_settings_popup.gd"

# Přepínač jazyka (krok K6 prototypu). Názvy jazyků se nepřekládají, každý je ve svém jazyce.

@onready var cestina: Button = %Cestina
@onready var english: Button = %English


func _ready() -> void:
	super()
	if Engine.is_editor_hint(): return
	cestina.pressed.connect(_vyber_jazyk.bind("cs"))
	english.pressed.connect(_vyber_jazyk.bind("en"))
	Jazyk.zmenen.connect(func(_jazyk): _oznac_jazyk())
	_oznac_jazyk()


func _vyber_jazyk(jazyk: String) -> void:
	Jazyk.nastav(jazyk)


func _oznac_jazyk() -> void:
	cestina.button_pressed = Jazyk.aktualni() == "cs"
	english.button_pressed = Jazyk.aktualni() == "en"
