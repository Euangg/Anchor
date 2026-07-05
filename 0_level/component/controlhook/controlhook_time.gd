extends Node2D

@onready var liftinghook:Node2D=$liftinghook

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_hook_trigger_trigger() -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	liftinghook.move()
