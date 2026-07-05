extends Node

var master_string_bank: FmodBank
var master_bank: FmodBank

var fmod_bgm_event:FmodEvent=null
var current_bgm_arg:float=0

func fmod_set_bgm_event(str:String):
	if fmod_bgm_event:
		fmod_bgm_event.stop(0)
		fmod_bgm_event.release()
		fmod_bgm_event=null
	fmod_bgm_event=FmodServer.create_event_instance(str)
	current_bgm_arg=fmod_bgm_event.get_parameter_by_name("Parameter 1")

func _ready() -> void:
	master_string_bank = FmodServer.load_bank("res://sound/banks/Master.strings.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	master_bank = FmodServer.load_bank("res://sound/banks/Master.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	
	fmod_bgm_event=FmodServer.create_event_instance("event:/Music/BGM")
	current_bgm_arg=fmod_bgm_event.get_parameter_by_name("Parameter 1")

func fmod_switch_bgm(parameter:String):
	Global.fmod_bgm_event.set_parameter_by_name_with_label("Parameter 1",parameter,true)
	current_bgm_arg=fmod_bgm_event.get_parameter_by_name("Parameter 1")
	fmod_bgm_event.start()

const UI_THEME = ("uid://br8cveyx7jnbe")
const UI_MAIN_MENU = ("uid://by742c56fpp4g")
const UI_INTRO = ("uid://ba67exr8li7ul")
const UI_PLAY = ("uid://v8tkkjyl8vhi")
const UI_ED = ("uid://cticoewlc4hel")

func switch_ui(path_scene):
	get_tree().call_deferred("change_scene_to_file",path_scene)


var is_aim:bool=false
