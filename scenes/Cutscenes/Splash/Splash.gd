extends Node2D

const Love4RetroScene = preload("res://scenes/Cutscenes/Love4Retro/Love4Retro.tscn")

onready var timer: Timer = $Timer
onready var transition_in: CanvasLayer = $TransitionIn
onready var transition_out: CanvasLayer = $TransitionOut


func _ready() -> void:
	print("Starting 'Phantomas en la sierra' version " + ProjectSettings.get("application/config/version"))
	Configuration.load_and_save_config()
	Utils.connect_signal(transition_in, "finished", self, "_on_transition_in_finished")
	Utils.connect_signal(transition_out, "finished", self, "_on_transition_out_finished")
	transition_in.start()


func _on_transition_in_finished():
	timer.start()


func _on_Timer_timeout() -> void:
	transition_out.start()


func _on_transition_out_finished():
	get_tree().change_scene_to(Love4RetroScene)
