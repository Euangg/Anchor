extends Control

const X_1_C = preload("uid://djpth7dps7oaq")
const X_1_O = preload("uid://dtpa27poww158")
const MAIN_02_START_C = preload("uid://hve2f710uohg")
const MAIN_02_START_O = preload("uid://dvtmqdeyt3kj5")

signal pressed

var mouse_on=false
func _on_area_2d_mouse_entered() -> void:
	%Sprite2D.texture=X_1_O
	%Sprite2D2.texture=MAIN_02_START_O
	mouse_on=true

func _on_area_2d_mouse_exited() -> void:
	%Sprite2D.texture=X_1_C
	%Sprite2D2.texture=MAIN_02_START_C
	mouse_on=false

func _physics_process(delta: float) -> void:
	if mouse_on and Input.is_action_just_pressed("mouse_left"):pressed.emit()
