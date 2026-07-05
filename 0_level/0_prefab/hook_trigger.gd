class_name Trigger
extends Node2D
const texture_triggered = preload("uid://btyus5hl3c6uw")

signal trigger
var triggered:bool=false

func _on_trigger() -> void:
	%Sprite2D.texture=texture_triggered
	FmodServer.play_one_shot("event:/SFX/Monster/hacking")
	triggered=true


func _physics_process(delta: float) -> void:
	if triggered:%Tip.visible=false
	else:
		%Tip.visible=Global.is_aim
