extends Node2D

func release():
	%Timer.start()
	%Range.monitorable=false

func _on_timer_timeout() -> void:
	%Range.monitorable=true
