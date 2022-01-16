extends Node2D

onready var ui = $UI
onready var camera: Camera2D = $Camera2D
onready var player: KinematicBody2D = $Player
onready var lifebar: TextureProgress = $UI/LifeBar
onready var transition_in: CanvasLayer = $TransitionIn
onready var transition_out: CanvasLayer = $TransitionOut
onready var remote_transform: RemoteTransform2D = $Player/RemoteTransform2D

const PineTreeScene: PackedScene = preload("res://scenes/World/Trees/PineTree.tscn")

var previous_level = null
var current_level = null
var next_map = null
var next_door_id = null


func _ready():
	Configuration.load_and_save_config()
	_load_level("Rio", null)


func _load_level(level_key, door_id):
	previous_level = current_level
	current_level = Levels.Data[level_key].scene.instance()
	next_door_id = door_id
	get_tree().current_scene.add_child_below_node(camera, current_level, false)
	_set_player()
	_set_camera_limits(current_level)
	_connect_signals()
	transition_in.texture_rect.visible = true
	transition_out.texture_rect.visible = false
	SoundManager.play_me(Levels.Data[current_level.id].background_music)
	transition_in.start()


func _set_player():
	if next_door_id != null:
		var doors = get_tree().get_nodes_in_group("DoorGroup")
		for door in doors:
			if door.id == next_door_id:
				player.position.x = door.position.x
				player.position.y = door.position.y + 48
				if door.enter_direction == "RIGHT":
					player.position.x -= 16
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


func _connect_signals():
	_connect_transitions()
	Utils.connect_signal(PlayerStats, "health_changed", self, "_on_health_changed")
	Utils.connect_signal(PlayerStats, "player_destroyed", self, "_on_player_destroyed")
	Utils.connect_signal(ui, "inventory_visible", self, "_on_inventory_visible")
	_connect_enemies()
	_connect_doors()


func _connect_transitions():
	Utils.connect_signal(transition_in, "transition_in_finished", self, "_on_transition_in_finished")
	Utils.connect_signal(transition_out, "transition_out_finished", self, "_on_transition_out_finished")


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


func _on_inventory_visible(ivisible):
	get_tree().paused = ivisible


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
