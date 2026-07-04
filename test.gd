extends Node2D


var vec_v=Vector2(100,0)
func _physics_process(delta: float) -> void:
	%HookPoint.position+=vec_v*delta
	


func _on_timer_timeout() -> void:
	vec_v*=-1
