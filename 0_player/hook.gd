class_name Hook
extends Node2D

const max_distance:float=800
const back_speed:float=1500

var velocity:Vector2
var master:Player=null
var target_bit:CollisionObject2D=null
var vec_target:Vector2
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
		
	if target_bit:position=vec_target+target_bit.global_position
	position+=velocity*delta
	
func back():
	is_back=true
	%Area2D.set_collision_mask_value(1,false)
	%Area2D.set_collision_mask_value(5,true)
	%Area2D.set_collision_mask_value(9,false)
	%Area2D.set_collision_mask_value(10,false)
	if target_bit:
		if target_bit.get_collision_layer_value(10):
			var hook_point=target_bit.get_parent()
			hook_point.release()
		target_bit=null

func set_target(thing:Node2D):
	target_bit=thing
	vec_target=position-target_bit.global_position

func bite(thing:Node2D):
	velocity=Vector2.ZERO
	if %RayCast2D.is_colliding():
		position=%RayCast2D.get_collision_point()
	if master.auto_drag:master.is_dragging=true
	set_target(thing)

func bite2(pos:Vector2,thing:Node2D):
	velocity=Vector2.ZERO
	position=pos
	if master.auto_drag:master.is_dragging=true
	set_target(thing)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(10):bite2(area.global_position,area)
	elif area.get_collision_layer_value(12):
		back()
		var t:Trigger=area.get_parent()
		t.trigger.emit()
		t.triggered=true
		area.set_deferred("monitorable",false)
	else:bite(area)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_collision_layer_value(1):
		if body.get_collision_layer_value(9):bite(body)
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
	
