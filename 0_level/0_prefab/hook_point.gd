extends Node2D

func release():
	%Timer.start()
	%Range.set_deferred("monitorable",false)

func _on_timer_timeout() -> void:
	%Range.monitorable=true
