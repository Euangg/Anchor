class_name Hook
extends Node2D

const max_distance:float=500
const back_speed:float=1500

var velocity:Vector2
var master:Player=null
var is_back:bool=false

func _ready() -> void:
	rotation=velocity.angle()

func _physics_process(delta: float) -> void:
	if is_back:
		var vec=master.hand.global_position-global_position
		velocity=vec.normalized()*back_speed
	else:
		var distance_square=global_position.distance_squared_to(master.global_position)
		if distance_square>pow(max_distance,2):back()
	position+=velocity*delta
	
func back():
	is_back=true
	%Area2D.set_collision_mask_value(1,false)
	%Area2D.set_collision_mask_value(5,true)
	%Area2D.set_collision_mask_value(9,false)

func bite():
	velocity=Vector2.ZERO
	if %RayCast2D.is_colliding():
		position=%RayCast2D.get_collision_point()
	if master.auto_drag:master.is_dragging=true

func _on_area_2d_area_entered(area: Area2D) -> void:
	bite()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_collision_layer_value(1):
		if body.get_collision_layer_value(9):bite()
		else:back()
	if body.get_collision_layer_value(5):
		if is_back:
			var player:Node2D=body
			player.last_hook=null
			#player.set_deferred("freeze",false)
			queue_free()
	if body.get_collision_layer_value(6):
		var enemy:Entity=body
		enemy.queue_free()
		back()
	
