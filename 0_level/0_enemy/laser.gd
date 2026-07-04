extends Node2D

#176
var time_acc=0
func _physics_process(delta: float) -> void:
	time_acc+=delta
	scale.y=1+0.5*sin(12*time_acc)

func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	var p:Player=body
	p.hurt.emit()
