extends Node2D

const TitleScene: PackedScene = preload("res://scenes/TitleScreen/TitleScreen.tscn")


func _ready():
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(TitleScene)
