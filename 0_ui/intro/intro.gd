extends Control

var current_p=0

func _ready() -> void:
	ResourceLoader.load_threaded_request(Global.UI_PLAY)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		if %AnimationPlayer.is_playing():pass
		else:
			if current_p>=2:
					Global.switch_ui(Global.UI_PLAY)
			else:
				current_p+=1
				%AnimationPlayer.play("p"+str(current_p))


func play_sfx_notice():
	FmodServer.play_one_shot("event:/UI/notice")
