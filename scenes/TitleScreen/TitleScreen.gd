extends Node2D

const MainScene: PackedScene = preload("res://scenes/Main/Main.tscn")

onready var menu_manager = $MenuManager
onready var transition_in = $TransitionIn
onready var transition_out = $TransitionOut
onready var audio_stream_player = $AudioStreamPlayer

var has_to_quit = false


func _ready():
	Utils.connect_signal(transition_in, "transition_in_finished", self, "_on_transition_in_finished")
	Utils.connect_signal(transition_out, "transition_out_finished", self, "_on_transition_out_finished")
	Utils.connect_signal(menu_manager, "menu_selected", self, "_on_menu_selected")
	transition_in.start()


func _on_menu_selected(menu):
	transition_out.start()
	has_to_quit = menu == "quit"


func _on_transition_in_finished():
	audio_stream_player.play()
	menu_manager.start()
	transition_in.queue_free()


func _on_transition_out_finished():
	if has_to_quit:
		get_tree().quit(0)
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(MainScene)
