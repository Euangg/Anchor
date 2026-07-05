extends Node2D

@export var durability:float=0.2

func _physics_process(delta: float) -> void:
	%Tip.visible=Global.is_aim
