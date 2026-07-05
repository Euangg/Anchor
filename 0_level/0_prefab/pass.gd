extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	%Timer.start()

func _on_timer_timeout() -> void:
	Global.switch_ui(Global.UI_ED)
