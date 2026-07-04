class_name Player
extends CharacterBody2D
const HOOK = preload("uid://cu87ycytrkccp")

signal hurt

enum Direction{LEFT=-1,RIGHT=1}
@onready var graphic: Node2D = $Graphic
@export var direction:Direction=Direction.RIGHT:
	set(v):
		direction=v
		if not is_node_ready():await ready
		graphic.scale.x=direction

enum State{NULL,
	IDLE,IDLE_RUN,RUN,
	SHOOT,PULL,FALL,HANG,
}
var current_state:State=State.NULL

@onready var hand: Node2D = $Hand

const gravity:float=1000
var last_hook:Hook=null
var dir_hand:Vector2=Vector2.ZERO
var drag_mode_once:bool=true
var is_dragging:bool=false
var reached:bool=false
var released:bool=false
#var recycled:bool=false
var auto_drag:bool=true

func _draw() -> void:
	draw_circle(hand.position,Hook.max_distance,Color.RED,false,-1)
	if last_hook:draw_line(hand.position,last_hook.position-position,Color.REBECCA_PURPLE,10)

func _process(delta: float) -> void:queue_redraw()


func _physics_process(delta: float) -> void:
	var shoot=false
	reached=false
	released=false
	
	var mouse_speed=Input.get_last_mouse_velocity()
	if mouse_speed.is_zero_approx():pass
	else:dir_hand=(get_global_mouse_position()-hand.global_position).normalized()
	
	var joy_right=Vector2(Input.get_joy_axis(0,JOY_AXIS_RIGHT_X),Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y))
	if joy_right.length_squared()<0.5:pass
	else:dir_hand=joy_right.normalized()
	
	hand.rotation=dir_hand.angle()
	
	#开发者全向移动
	var input=Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if input.is_zero_approx():pass
	else:velocity=input*500
	#手动挡移动
	#if Input.is_action_just_pressed("tab"):drag_mode_once=!drag_mode_once
	#if Input.is_action_just_pressed("q"):auto_drag=!auto_drag
	
	var input_x=Input.get_axis("a","d")
	if is_zero_approx(input_x):pass
	else:direction=Direction.LEFT if input_x<0 else Direction.RIGHT
	
	if Input.is_action_just_pressed("mouse_left"):
		if last_hook:
			released=true
			is_dragging=false
			last_hook.back()
		else:
			var h:Hook=HOOK.instantiate()
			h.global_position=hand.global_position
			h.velocity=dir_hand*3000
			h.master=self
			add_sibling(h)
			last_hook=h
			FmodServer.play_one_shot("event:/SFX/HOOK/CASTING")
			shoot=true
	
	#手动挡、拉钩
	#if drag_mode_once:
		#if Input.is_action_just_pressed("mouse_right"):
			#if is_dragging:is_dragging=false
			#else:
				#if last_hook and (last_hook.velocity.is_zero_approx()):start_drag()
	#else:
		#if Input.is_action_just_pressed("mouse_right"):start_drag()
		#if Input.is_action_just_released("mouse_right"):is_dragging=false
	
	if Input.is_action_just_pressed("mouse_right"):show_aim()
	if Input.is_action_just_released("mouse_right"):hide_aim()
	
	
	
	var next_state=current_state
	#1/3.状态判断
	match current_state:
		State.NULL:next_state=State.IDLE
		State.IDLE:
			if shoot:next_state=State.SHOOT
			if is_zero_approx(input_x):pass
			else:next_state=State.IDLE_RUN
			if is_on_floor():pass
			else:next_state=State.FALL
			if is_dragging:next_state=State.PULL
		State.IDLE_RUN:
			if %AnimationPlayer.is_playing():
				if is_zero_approx(input_x):next_state=State.IDLE
			else:next_state=State.RUN
			if is_dragging:next_state=State.PULL
		State.RUN:
			if is_zero_approx(input_x):next_state=State.IDLE
			if is_dragging:next_state=State.PULL
		State.SHOOT:
			if last_hook:pass
			else:next_state=State.IDLE
			if is_dragging:next_state=State.PULL
		State.PULL:
			if not is_dragging:next_state=State.FALL
			if reached:next_state=State.HANG
			if released:next_state=State.FALL
			if last_hook:pass
			else:next_state=State.FALL
		State.HANG:
			if released:
				if is_on_floor():next_state=State.IDLE
				else:next_state=State.FALL
		State.FALL:
			if is_on_floor():next_state=State.IDLE
			if is_dragging:next_state=State.PULL
	#2/3.状态切换
	if next_state==current_state:pass
	else:
		match current_state:
			State.IDLE:pass
		match next_state:
			State.IDLE:%AnimationPlayer.play("idle")
			State.IDLE_RUN:%AnimationPlayer.play("idle_run",-1,2)
			State.RUN:%AnimationPlayer.play("run",-1,2)
			State.SHOOT:%AnimationPlayer.play("shoot")
			State.PULL:%AnimationPlayer.play("pull")
			State.HANG:%AnimationPlayer.play("hang")
			State.FALL:%AnimationPlayer.play("fall")
		current_state=next_state
	#3/3.状态运行
	match current_state:
		State.IDLE:
			velocity.x=input_x*500
		State.IDLE_RUN:
			velocity.x=input_x*500
		State.RUN:
			velocity.x=input_x*500
		State.PULL:
			if last_hook:
				var diff_x=last_hook.global_position.x-global_position.x
				if is_zero_approx(diff_x):pass
				else:direction=sign(diff_x)
				if is_dragging:drag(delta)
		State.FALL:
			velocity.x=input_x*500
		
	
	velocity.y+=gravity*delta
	move_and_slide()

func start_drag():
	is_dragging=true
	FmodServer.play_one_shot("event:/SFX/HOOK/FLYING")

func show_aim():
	%Arrow.visible=true
	%Ring.visible=true
	FmodServer.play_one_shot("event:/SFX/AIMING/AIM_IN")
	Engine.time_scale=0.1

func hide_aim():
	%Arrow.visible=false
	%Ring.visible=false
	FmodServer.play_one_shot("event:/SFX/AIMING/AIM_OUT")
	Engine.time_scale=1

func drag(delta):
	if last_hook and (last_hook.velocity.is_zero_approx()):
		var vec_hook_hand:Vector2=last_hook.global_position-hand.global_position
		if vec_hook_hand.length_squared()<=100:
			velocity=Vector2.ZERO
			global_position=last_hook.global_position-hand.position
			reached=true
		else:velocity=vec_hook_hand.normalized()*700
		if last_hook.target_bit:
			if last_hook.target_bit.get_collision_layer_value(11):
				var duration_thing=last_hook.target_bit.get_parent()
				duration_thing.durability-=delta
				if duration_thing.durability<=0:
					duration_thing.queue_free()
					is_dragging=false
					last_hook.back()

func play_sfx_footstep():
	FmodServer.play_one_shot("event:/PLAYER/WALK")

func _on_hurt() -> void:
	print("hurt")
