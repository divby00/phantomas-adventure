extends Node2D


const BACKGROUND_SCROLL_SPEED: int = 12
const WorldScene: PackedScene = preload("res://scenes/World/World.tscn")
const WindScene: PackedScene = preload("res://scenes/TitleScreen/Wind/Wind.tscn")

onready var menu_manager = $MenuManager
onready var transition_in = $TransitionIn
onready var parallax = $ParallaxBackground
onready var transition_out = $TransitionOut
onready var wind_timer: Timer = $WindTimer
onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var has_to_quit: bool = false


func _ready():
	Utils.connect_signal(transition_in, "transition_in_finished", self, "_on_transition_in_finished")
	Utils.connect_signal(transition_out, "transition_out_finished", self, "_on_transition_out_finished")
	Utils.connect_signal(menu_manager, "menu_selected", self, "_on_menu_selected")
	transition_in.start()
	_prepare_timer()


func _process(delta: float) -> void:
	# Animate background
	parallax.scroll_offset.x -= BACKGROUND_SCROLL_SPEED * delta


func _prepare_timer():
	wind_timer.wait_time = rand_range(0.1, 0.5)
	wind_timer.start()


func _on_menu_selected(menu):
	transition_out.start()
	has_to_quit = menu == "quit"


func _on_transition_in_finished():
	audio_stream_player.play()
	menu_manager.start()
	transition_in.queue_free()


func _on_transition_out_finished():
	if has_to_quit:
		get_tree().quit(0) # Quit
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(WorldScene) # Begin game


func _on_WindTimer_timeout() -> void:
	var wind = WindScene.instance()
	Utils.connect_signal(wind, "finished", self, "_on_wind_finished")
	get_tree().current_scene.add_child(wind)


func _on_wind_finished(wind):
	wind.queue_free()
	_prepare_timer()
