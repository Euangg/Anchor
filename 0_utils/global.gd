extends Node

var master_string_bank: FmodBank
var master_bank: FmodBank

func _ready() -> void:
	master_string_bank = FmodServer.load_bank("res://sound/banks/Master.strings.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	master_bank = FmodServer.load_bank("res://sound/banks/Master.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)


const UI_THEME = ("uid://br8cveyx7jnbe")
const UI_MAIN_MENU = ("uid://by742c56fpp4g")
const UI_PLAY = ("uid://v8tkkjyl8vhi")

func switch_ui(path_scene):
	get_tree().call_deferred("change_scene_to_file",path_scene)
