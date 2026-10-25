extends "simple_click_bar.gd"

# Na dotykovém zařízení není najetí myší, takže se lišta s inventářem a nastavením
# nikdy neukáže sama. Proto je tam trvale viditelná (krok K8 prototypu).


func _ready() -> void:
	if DisplayServer.is_touchscreen_available():
		always_visible = true
	super()
