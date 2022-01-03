extends Node2D

export var texture: Texture = null

onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	randomize()
	sprite.texture = texture
	animation_player.play("idle")


func _on_Tree_area_entered(_area: Area2D) -> void:
	animation_player.play("wind")


func _on_Tree_area_exited(_area: Area2D) -> void:
	animation_player.queue("idle")
