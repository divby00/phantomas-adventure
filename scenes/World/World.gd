extends Node2D

onready var camera: Camera2D = $Camera2D
onready var lifebar: TextureProgress = $UI/LifeBar
onready var ui = $UI

const Levels = {"Rio": preload("res://scenes/World/Maps/Level01/Rio.tscn")}
const PineTreeScene: PackedScene = preload("res://scenes/World/Trees/PineTree.tscn")


func _ready():
	Configuration.load_and_save_config()
	_load_level("Rio")


func _load_level(level_key):
	var level = Levels[level_key].instance()
	_set_camera_limits(level)
	get_tree().current_scene.add_child_below_node(camera, level, false)
	var player = get_tree().get_nodes_in_group("PlayerGroup")[0]
	var player_remote_transform: RemoteTransform2D = player.get_node("RemoteTransform2D")
	player_remote_transform.remote_path = "../../../../../Camera2D"
	_connect_signals()


func _set_camera_limits(level):
	camera.limit_left = level.camera_limit_left
	camera.limit_top = level.camera_limit_top
	camera.limit_right = level.camera_limit_right
	camera.limit_bottom = level.camera_limit_bottom


func _connect_signals():
	Utils.connect_signal(PlayerStats, "health_changed", self, "_on_health_changed")
	Utils.connect_signal(PlayerStats, "player_destroyed", self, "_on_player_destroyed")
	Utils.connect_signal(ui, "inventory_visible", self, "_on_inventory_visible")
	_connect_enemies()


func _connect_enemies():
	pass


func _on_health_changed(health):
	lifebar.value = health


func _on_player_destroyed():
	pass


func _on_inventory_visible(ivisible):
	get_tree().paused = ivisible
