extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	player_dead()
	

var invincible=false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):Global.switch_ui(Global.UI_THEME)
	if Input.is_action_just_pressed("num_1"):invincible=!invincible

func _on_player_hurt() -> void:
	if invincible:pass
	else:player_dead()

func player_dead():
	FmodServer.play_one_shot("event:/PLAYER/death")
	%Player.modulate=Color.RED
	%Player.process_mode=Node.PROCESS_MODE_DISABLED
	%Timer.start()


func _on_timer_timeout() -> void:
	get_tree().call_deferred("reload_current_scene")
