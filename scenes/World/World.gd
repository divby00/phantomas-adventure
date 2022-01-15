extends Node2D

onready var ui = $UI
onready var camera: Camera2D = $Camera2D
onready var lifebar: TextureProgress = $UI/LifeBar
onready var transition_in: CanvasLayer = $TransitionIn
onready var transition_out: CanvasLayer = $TransitionOut

const PineTreeScene: PackedScene = preload("res://scenes/World/Trees/PineTree.tscn")

var previous_level = null
var current_level = null
var next_map = null


func _ready():
	Configuration.load_and_save_config()
	_load_level("Rio")


func _load_level(level_key):
	previous_level = current_level
	current_level = Levels.Data[level_key].scene.instance()
	get_tree().current_scene.add_child_below_node(camera, current_level, false)
	_set_camera_limits(current_level)
	_connect_signals()
	transition_out.texture_rect.visible = false
	transition_in.start()


func _set_camera_limits(level):
	camera.limit_left = level.camera_limit_left
	camera.limit_top = level.camera_limit_top
	camera.limit_right = level.camera_limit_right
	camera.limit_bottom = level.camera_limit_bottom
	var player = get_tree().get_nodes_in_group("PlayerGroup")[0]
	var player_remote_transform: RemoteTransform2D = player.get_node("RemoteTransform2D")
	player_remote_transform.remote_path = "../../../../../Camera2D"


func _connect_signals():
	Utils.connect_signal(transition_out, "transition_out_finished", self, "_on_transition_out_finished")
	Utils.connect_signal(PlayerStats, "health_changed", self, "_on_health_changed")
	Utils.connect_signal(PlayerStats, "player_destroyed", self, "_on_player_destroyed")
	Utils.connect_signal(ui, "inventory_visible", self, "_on_inventory_visible")
	_connect_enemies()
	_connect_doors()


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
	transition_out.texture_rect.visible = true
	transition_out.start()
	next_map = door.next_map


func _on_transition_out_finished():
	current_level.queue_free()
	_load_level(next_map)
