class_name Hook
extends Node2D

const max_distance:float=500
const back_speed:float=1500

var velocity:Vector2
var master:Node2D=null
var is_back:bool=false

func _ready() -> void:
	rotation=velocity.angle()

func _physics_process(delta: float) -> void:
	if is_back:
		var vec=master.global_position-global_position
		velocity=vec.normalized()*back_speed
	else:
		var distance_square=global_position.distance_squared_to(master.global_position)
		if distance_square>pow(max_distance,2):back()
	position+=velocity*delta
	
func back():
	is_back=true
	%Area2D.set_collision_mask_value(5,true)
	%Area2D.set_collision_mask_value(9,false)


func hit():
	velocity=Vector2.ZERO
	if %RayCast2D.is_colliding():
		position=%RayCast2D.get_collision_point()
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	hit()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	hit()
	if is_back:
		var player:Player=body
		player.last_hook=null
		queue_free()
