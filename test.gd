extends Node2D

@onready var juanlianmen: Node2D = $Juanlianmen

func _on_hook_trigger_trigger() -> void:
	juanlianmen.open()
