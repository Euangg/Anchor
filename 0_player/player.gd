class_name Player
extends CharacterBody2D
const HOOK = preload("uid://cu87ycytrkccp")

const gravity:float=10000
var last_hook:Hook=null
var dir_hand:Vector2=Vector2.ZERO

func _draw() -> void:
	draw_circle(%Hand.position,Hook.max_distance,Color.RED,false,-1)
	if last_hook:draw_line(Vector2(0,0),last_hook.position-position,Color.REBECCA_PURPLE,10)
	

func _physics_process(delta: float) -> void:
	queue_redraw()
	var mouse_speed=Input.get_last_mouse_velocity()
	if mouse_speed.is_zero_approx():pass
	else:dir_hand=(get_global_mouse_position()-%Hand.global_position).normalized()
	
	var joy_right=Vector2(Input.get_joy_axis(0,JOY_AXIS_RIGHT_X),Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y))
	if joy_right.length_squared()<0.5:pass
	else:dir_hand=joy_right.normalized()
	
	%Hand.rotation=dir_hand.angle()	
	
	var input=Input.get_vector("a","d","w","s")
	velocity=input*500
	velocity.y+=gravity*delta
	
	if Input.is_action_just_pressed("mouse_left"):
		if last_hook:
			last_hook.back()
		else:
			var h:Hook=HOOK.instantiate()
			h.global_position=%Hand.global_position
			h.velocity=dir_hand*3000
			h.master=self
			add_sibling(h)
			last_hook=h
		
	if Input.is_action_pressed("mouse_right"):
		if last_hook and (last_hook.velocity.is_zero_approx()):
			var vec_hook_hand:Vector2=last_hook.global_position-%Hand.global_position
			if vec_hook_hand.length_squared()<=100:velocity=Vector2.ZERO
			else:velocity+=vec_hook_hand.normalized()*60000*delta
			
	move_and_slide()
