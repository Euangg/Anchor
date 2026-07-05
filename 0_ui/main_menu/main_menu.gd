extends Control


func _on_button_start_pressed() -> void:
	Global.switch_ui(Global.UI_PLAY)
	Global.fmod_switch_bgm("1")


func _on_button_quit_pressed() -> void:
	get_tree().quit()
