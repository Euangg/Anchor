extends Control

const X_2_C = preload("uid://cxr5icbakq65c")
const X_2_O = preload("uid://b8ew30cxsmx20")
const MAIN_02_QUIT_C = preload("uid://fkc1ny2pv4ui")
const MAIN_02_QUIT_O = preload("uid://cxp8qg3drf42j")


signal pressed

var mouse_on=false
func _on_area_2d_mouse_entered() -> void:
	%Sprite2D.texture=X_2_O
	%Sprite2D2.texture=MAIN_02_QUIT_O
	mouse_on=true

func _on_area_2d_mouse_exited() -> void:
	%Sprite2D.texture=X_2_C
	%Sprite2D2.texture=MAIN_02_QUIT_C
	mouse_on=false

func _physics_process(delta: float) -> void:
	if mouse_on and Input.is_action_just_pressed("mouse_left"):pressed.emit()
