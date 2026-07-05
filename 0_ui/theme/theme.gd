extends Control

var time_acc=0

var logo_shader:ShaderMaterial
func _ready() -> void:
	logo_shader=%Logo.material
	Global.fmod_switch_bgm("2")
	

func _physics_process(delta: float) -> void:
	time_acc+=delta
	%Flash01.offset.y=20*sin(PI*time_acc)
	%Flash02.offset.y=20*sin(PI*time_acc+5)
	
	logo_shader.set_shader_parameter("outline_width",6+5*sin(0.5*PI*time_acc))
	%Label.modulate.a=(1+sin(PI*time_acc))*0.5

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		Global.switch_ui(Global.UI_MAIN_MENU)
