extends Node2D

const MenuScene: PackedScene = preload("res://scenes/Menu/Menu.tscn")


func _ready():
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(MenuScene)
