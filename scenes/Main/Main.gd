extends Node2D

const MenuScene = preload("res://scenes/Menu/Menu.tscn")

func _ready():
	get_tree().change_scene_to(MenuScene)
