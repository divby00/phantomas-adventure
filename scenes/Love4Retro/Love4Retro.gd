extends Node2D

const IntroScene = preload("res://scenes/Intro/Intro.tscn")
const VERSION = "0.0.1"

onready var transition_in = $TransitionIn
onready var transition_out = $TransitionOut
onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	transition_in.start()
	print("Starting 'Phantomas en la sierra' version " + VERSION);
	Configuration.load_and_save_config()
	Utils.connect_signal(transition_in, "transition_in_finished", self, "on_transition_in_finished")
	Utils.connect_signal(transition_out, "transition_out_finished", self, "on_transition_out_finished")


func _on_AudioStreamPlayer_finished():
	transition_out.start()


func on_transition_in_finished():
	audio_stream_player.play()


func on_transition_out_finished():
	get_tree().change_scene_to(IntroScene)
