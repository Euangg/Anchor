extends Node

var master_string_bank: FmodBank
var master_bank: FmodBank

func _ready() -> void:
	master_string_bank = FmodServer.load_bank("res://sound/banks/Master.strings.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	master_bank = FmodServer.load_bank("res://sound/banks/Master.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
