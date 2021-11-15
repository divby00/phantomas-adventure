extends Node2D

onready var transition_in = $TransitionIn
onready var main_menu = $MainMenu/NinePatchRect
onready var audio_stream_player = $AudioStreamPlayer
onready var menu_manager = $MenuManager


func _ready():
	Utils.connect_signal(transition_in, "transition_in_finished", self, "on_transition_in_finished")
	transition_in.start()


func on_transition_in_finished():
	audio_stream_player.play()
	menu_manager.start()