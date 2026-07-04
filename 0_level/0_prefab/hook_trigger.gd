class_name Trigger
extends Node2D
const texture_triggered = preload("uid://btyus5hl3c6uw")

signal trigger
var triggered:bool=false


func _on_trigger() -> void:
	%Sprite2D.texture=texture_triggered
