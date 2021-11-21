extends Node2D


onready var dialog = $Dialog

func _ready() -> void:
	dialog.start()
