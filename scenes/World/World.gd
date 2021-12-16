extends Node2D


onready var player: KinematicBody2D = $Player

const Levels = {
	"01": preload("res://scenes/World/Levels/Level01.tscn")
}

func _ready():
	Configuration.load_and_save_config()
	_load_level("01")


func _load_level(level_key):
	var level = Levels[level_key].instance()
	get_tree().current_scene.add_child(level)
	_connect_signals()


func _connect_signals():
	pass
#	var platforms = get_tree().get_nodes_in_group("PlatformGroup")
#	for platform in platforms:
#		Utils.connect_signal(platform, "is_over_platform", player, "_over_platform")
