extends Node2D

var is_moving : bool = false
var dest = - 4200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func move () :
	is_moving = true
func _physics_process(delta: float) -> void:
	if is_moving :
		print("Before move: ", position.y, " dest: ", dest)
		position.y -= delta * 500
		print("After move: ", position.y)
		if position.y < dest :
			position.y = dest
			print("Clamped to dest: ", position.y)
			is_moving = false
