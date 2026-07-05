extends Node2D


func play_sfx():
	FmodServer.play_one_shot("event:/SFX/Monster/EXPLOSION")
