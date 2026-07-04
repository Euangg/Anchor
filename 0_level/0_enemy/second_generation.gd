extends Entity
const LASER = preload("uid://coqt65474ojwr")

var last_dir=1
func _ready() -> void:
	linear_velocity=Vector2(0,100)

func _physics_process(delta: float) -> void:
	if %AnimationPlayer.current_animation=="pre_atk":pass
	else:
		var obj:CollisionObject2D=%RayCast2D.get_collider()
		if obj and obj.get_collision_layer_value(5):
			%AnimationPlayer.play("pre_atk")

func shoot():
	var sss=1
	var obj:CollisionObject2D=%RayCastWall.get_collider()
	if obj:
		var p:Vector2=%RayCastWall.get_collision_point()
		var diff_x=abs(p.x-%RayCastWall.global_position.x)
		sss=diff_x/824
	var l:Node2D=LASER.instantiate()
	l.scale.x=direction*sss
	l.global_position=%RayCast2D.global_position
	add_sibling(l)

func stop_move():
	last_dir=sign(linear_velocity.y)
	linear_velocity.y=0
	%Timer.paused=true

func continue_move():
	linear_velocity.y=100*last_dir
	%Timer.paused=false

func _on_timer_timeout() -> void:
	linear_velocity*=-1
