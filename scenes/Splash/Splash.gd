extends Node2D


const Love4RetroScene = preload("res://scenes/Love4Retro/Love4Retro.tscn")


func _ready() -> void:
	print("Starting 'Phantomas en la sierra' version " + ProjectSettings.get("application/config/version"));
	Configuration.load_and_save_config()


func _on_Timer_timeout() -> void:
	get_tree().change_scene_to(Love4RetroScene)
