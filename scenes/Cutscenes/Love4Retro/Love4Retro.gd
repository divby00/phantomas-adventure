extends Node2D

const TitleScreen = preload("res://scenes/TitleScreen/TitleScreen.tscn")

onready var transition_in = $TransitionIn
onready var transition_out = $TransitionOut


func _ready():
	transition_in.start()
	SoundManager.play_se("L4R")
	Utils.connect_signal(transition_in, "finished", self, "_on_transition_in_finished")
	Utils.connect_signal(transition_out, "finished", self, "_on_transition_out_finished")


func _on_transition_in_finished():
	pass


func _on_transition_out_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(TitleScreen)


func _on_Timer_timeout() -> void:
	transition_out.start()
