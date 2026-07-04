extends Entity
const LASER = preload("uid://coqt65474ojwr")


func _physics_process(delta: float) -> void:
	if %AnimationPlayer.current_animation=="pre_atk":pass
	else:if %RayCast2D.is_colliding():%AnimationPlayer.play("pre_atk")

func shoot():
	var l:Node2D=LASER.instantiate()
	l.scale.x=direction
	l.global_position=%RayCast2D.global_position
	add_sibling(l)
