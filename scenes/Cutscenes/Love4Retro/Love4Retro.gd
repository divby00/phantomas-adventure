extends Node2D

const TitleScreen = preload("res://scenes/TitleScreen/TitleScreen.tscn")

onready var transition_in = $TransitionIn
onready var transition_out = $TransitionOut


func _ready():
	transition_in.start()
	Utils.connect_signal(transition_in, "transition_in_finished", self, "on_transition_in_finished")
	Utils.connect_signal(transition_out, "transition_out_finished", self, "on_transition_out_finished")


func on_transition_in_finished():
	SoundManager.play_se("L4R")


func on_transition_out_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(TitleScreen)


func _on_Timer_timeout() -> void:
	transition_out.start()
