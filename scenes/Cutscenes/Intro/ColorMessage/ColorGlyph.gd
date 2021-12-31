extends Node2D

onready var label: Label = $Label
onready var animation_player: AnimationPlayer = $AnimationPlayer

var character: String


func start():
	label.text = character
	animation_player.play("animate")


func on_remove():
	animation_player.play("remove")
