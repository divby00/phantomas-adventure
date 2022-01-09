extends Node2D

onready var camera: Camera2D = $Camera2D
onready var player: KinematicBody2D = $Player
onready var lifebar: TextureProgress = $UI/LifeBar
onready var ui = $UI

const Levels = {"01": preload("res://scenes/World/Levels/Level01.tscn")}
const PineTreeScene: PackedScene = preload("res://scenes/World/Trees/PineTree.tscn")


func _ready():
	Configuration.load_and_save_config()
	_load_level("01")


func _load_level(level_key):
	var level = Levels[level_key].instance()
	_set_camera_limits(level)
	_set_level_entities(level)
	get_tree().current_scene.add_child_below_node(camera, level, false)
	_connect_signals()


func _set_level_entities(level):
	var data = level.get_node("./Data/Rio_nivel_1/Entities")
	var entities: Array = data.get_children()
	for entity in entities:
		if entity.name == 'Start':
			print('start found!')
		if entity.name == 'PineTree':
			var pine = PineTreeScene.instance()
			level.add_child(pine)
			print(entity)
			pine.position = entity.position
			print(entity.position)


func _set_camera_limits(level):
	camera.limit_left = level.camera_limit_left
	camera.limit_top = level.camera_limit_top - 32
	camera.limit_right = level.camera_limit_right
	camera.limit_bottom = level.camera_limit_bottom + 16


func _connect_signals():
	Utils.connect_signal(PlayerStats, "health_changed", self, "_on_health_changed")
	Utils.connect_signal(PlayerStats, "player_destroyed", self, "_on_player_destroyed")
	Utils.connect_signal(ui, "inventory_visible", self, "_on_inventory_visible")
	_connect_enemies()
	pass


#	var platforms = get_tree().get_nodes_in_group("PlatformGroup")
#	for platform in platforms:
#		Utils.connect_signal(platform, "is_over_platform", player, "_over_platform")


func _connect_enemies():
	pass


#	var enemies = get_tree().get_nodes_in_group("EnemyGroup")
#	for enemy in enemies:
#		Utils.connect_signal(enemy, "")


func _on_health_changed(health):
	lifebar.value = health


func _on_player_destroyed():
	pass


func _on_inventory_visible(ivisible):
	get_tree().paused = ivisible
