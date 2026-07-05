extends Control

@onready var edsilk: Sprite2D = $Edsilk
@onready var theend: Sprite2D = $Theend
@onready var label_2: Label = %Label2

@export var can_back:bool=false

func _unhandled_input(event: InputEvent) -> void:
	if can_back:
		if event.is_pressed():Global.switch_ui(Global.UI_THEME)


var time_acc=0
func _physics_process(delta: float) -> void:
	time_acc+=delta
	edsilk.modulate.a=(1+sin(time_acc+3*PI/2))*0.5
	
	theend.offset.y=15*sin(PI*time_acc)
	label_2.offset_transform_position.y=15*sin(PI*time_acc)
