extends Node2D

func _physics_process(delta: float) -> void:
	%Tip.visible=Global.is_aim

func release():
	%Timer.start()
	%Range.set_deferred("monitorable",false)

func _on_timer_timeout() -> void:
	%Range.monitorable=true
