class_name Entity
extends RigidBody2D
enum Direction{LEFT=-1,RIGHT=1}

@onready var graphic: Node2D = $Graphic
@export var direction:Direction=Direction.RIGHT:
	set(v):
		direction=v
		if not is_node_ready():await ready
		graphic.scale.x=direction
