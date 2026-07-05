extends Node2D

@export var rope_anchor_global_y:float=-432
@export var rope_end_offset:Vector2=Vector2(0,-56)
@export var rope_width:float=6

@onready var rope_line:Line2D=$RopeLine
@onready var liftinghook:Node2D=$liftinghook

func _ready() -> void:
	rope_line.width=rope_width
	update_rope()

func _process(delta: float) -> void:
	update_rope()

func _on_hook_trigger_trigger() -> void:
	liftinghook.move()

func update_rope() -> void:
	var rope_end:=liftinghook.position+rope_end_offset
	var rope_anchor:=to_local(Vector2(liftinghook.global_position.x,rope_anchor_global_y))
	rope_line.points=[
		rope_anchor,
		rope_end,
	]
