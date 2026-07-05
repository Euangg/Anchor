class_name Entity
extends RigidBody2D
enum Direction{LEFT=-1,RIGHT=1}
const BOOM = preload("uid://d1p4rkxlmquf7")


signal dead

@onready var graphic: Node2D = $Graphic
@onready var marker_boom: Marker2D = $Graphic/MarkerBoom
@export var direction:Direction=Direction.RIGHT:
	set(v):
		direction=v
		if not is_node_ready():await ready
		graphic.scale.x=direction


func die_leave_effect(e:PackedScene):
	var effect:Node2D=e.instantiate()
	effect.position=marker_boom.global_position
	add_sibling(effect)
	dead.emit()
	queue_free()


func play_sfx_warning():
	FmodServer.play_one_shot("event:/SFX/Monster/warining")
