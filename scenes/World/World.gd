extends Node2D

onready var ui = $UI
onready var camera: Camera2D = $Camera2D
onready var player: KinematicBody2D = $Player
onready var lifebar: TextureProgress = $UI/LifeBar
onready var transition_in: CanvasLayer = $TransitionIn
onready var transition_out: CanvasLayer = $TransitionOut
onready var remote_transform: RemoteTransform2D = $Player/RemoteTransform2D
onready var level_node:Node2D = $Level
onready var cinematic_node:Node2D = $Cinematic

const PineTreeScene: PackedScene = preload("res://scenes/World/Trees/PineTree.tscn")

var previous_level = null
var current_level = null
var next_map = null
var next_door_id = null
var cinematic_scene:Cinematic = null

func _ready():
	Configuration.load_and_save_config()
	_connect_ui()
	_connect_transitions()
	_load_level("Rio", null)

	#Esto es solo para probar la cinematica
	Utils.connect_signal(player, "collision_cinematic", self, "_on_player_collision_cinematic")

func _on_player_collision_cinematic(_item):
	_play_cinematic("res://scenes/Tests/TestDialog.tscn")


func _load_level(level_key, door_id):
	previous_level = current_level
	current_level = Levels.Data[level_key].scene.instance()
	next_door_id = door_id
	level_node.add_child(current_level)
	_set_player()
	_set_camera_limits(current_level)
	_connect_level_signals()
	transition_in.texture_rect.visible = true
	transition_out.texture_rect.visible = false
	SoundManager.play_me(Levels.Data[current_level.id].background_music)
	transition_in.start()

func _play_cinematic(scene_resource_path):
	_pause_world(true)
	cinematic_scene = load(scene_resource_path).instance()
	Utils.connect_signal(cinematic_scene, "cinematic_start", self, "_on_cinematic_start")
	Utils.connect_signal(cinematic_scene, "cinematic_end", self, "_on_cinematic_end")
	ui.show_cinemascope_bars()

func _set_player():
	if next_door_id != null:
		var doors = get_tree().get_nodes_in_group("DoorGroup")
		for door in doors:
			if door.id == next_door_id:
				player.position.x = door.position.x
				player.position.y = door.position.y + 48
				if door.enter_direction == "RIGHT":
					player.position.x -= 18
				else:
					player.position.x -= 1
				break
	else:
		var entrance = current_level.get_entrance()
		if entrance != null:
			player.position = entrance.position


func _set_camera_limits(level):
	camera.limit_left = level.camera_limit_left
	camera.limit_top = level.camera_limit_top
	camera.limit_right = level.camera_limit_right
	camera.limit_bottom = level.camera_limit_bottom
	remote_transform.remote_path = "../../Camera2D"


func _connect_level_signals():
	Utils.connect_signal(PlayerStats, "health_changed", self, "_on_health_changed")
	Utils.connect_signal(PlayerStats, "player_destroyed", self, "_on_player_destroyed")
	_connect_enemies()
	_connect_doors()


func _connect_ui():
	Utils.connect_signal(ui, "inventory_visible", self, "_on_inventory_visible")
	Utils.connect_signal(ui, "gamemenu_visible", self, "_on_gamemenu_visible")
	Utils.connect_signal(ui, "gamemenu_selected_option", self, "_on_gamemenu_selected_option")
	Utils.connect_signal(ui, "cinemascope_start", self, "_on_cinemascope_start")
	Utils.connect_signal(ui, "cinemascope_end", self, "_on_cinemascope_end")


func _connect_transitions():
	Utils.connect_signal(transition_in, "finished", self, "_on_transition_in_finished")
	Utils.connect_signal(transition_out, "finished", self, "_on_transition_out_finished")
	Utils.connect_signal(transition_out, "started", ui, "_on_transition_out_started")
	Utils.connect_signal(transition_in, "finished", ui, "_on_transition_in_finished")


func _connect_enemies():
	pass


func _connect_doors():
	var doors = get_tree().get_nodes_in_group("DoorGroup")
	for door in doors:
		Utils.connect_signal(door, "door_entered", self, "_on_door_entered")


func _on_health_changed(health):
	lifebar.value = health


func _on_player_destroyed():
	pass

func _pause_world(pause):
	get_tree().paused = pause

func _on_inventory_visible(ivisible):
	_pause_world(ivisible)

func _on_gamemenu_visible(ivisible):
	_pause_world(ivisible)


func _on_gamemenu_selected_option(option):
	if option.text == "MENU_CHOICE_EXIT_YES":
		SoundManager.stop(Levels.Data[current_level.id].background_music)
		get_tree().paused = false
		get_tree().change_scene_to(load("res://scenes/TitleScreen/TitleScreen.tscn"))


func _on_door_entered(door):
	next_map = door.next_map
	next_door_id = door.next_door_id
	transition_out.texture_rect.visible = true
	transition_out.start()


func _on_transition_in_finished():
	transition_in.texture_rect.visible = false


func _on_transition_out_finished():
	SoundManager.stop(Levels.Data[current_level.id].background_music)
	current_level.queue_free()
	_load_level(next_map, next_door_id)

func _on_cinemascope_start():
	cinematic_node.add_child(cinematic_scene)

func _on_cinemascope_end():
	_pause_world(false)

func _on_cinematic_start():
	pass

func _on_cinematic_end():
	cinematic_scene.queue_free()
	ui.hide_cinemascope_bars()
