# Jazyk hry: přepínání češtiny a angličtiny za běhu a zapamatování volby (D3: oba jazyky zároveň).
# Volba se ukládá do user://nastaveni.cfg; při prvním spuštění se řídí jazykem systému.
extends Node

## Vyšle se po změně jazyka (texty v uzlech Godot přeloží sám, tohle je pro vlastní logiku)
signal zmenen(jazyk: String)

const JAZYKY := ["cs", "en"]
const SOUBOR := "user://nastaveni.cfg"


func _ready() -> void:
	var cfg := ConfigFile.new()
	var vychozi := "cs" if OS.get_locale_language() == "cs" else "en"
	if cfg.load(SOUBOR) == OK:
		vychozi = cfg.get_value("hra", "jazyk", vychozi)
	TranslationServer.set_locale(vychozi)


## Aktuální jazyk hry („cs“ nebo „en“)
func aktualni() -> String:
	return TranslationServer.get_locale().substr(0, 2)


## Přepne jazyk a uloží volbu
func nastav(jazyk: String) -> void:
	if not jazyk in JAZYKY:
		push_error("Neznámý jazyk: %s" % jazyk)
		return
	TranslationServer.set_locale(jazyk)
	var cfg := ConfigFile.new()
	cfg.load(SOUBOR)
	cfg.set_value("hra", "jazyk", jazyk)
	cfg.save(SOUBOR)
	zmenen.emit(jazyk)
