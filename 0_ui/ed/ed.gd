extends Control


func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():Global.switch_ui(Global.UI_THEME)
