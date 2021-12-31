extends Node2D

onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	randomize()
	animation_player.queue("idle")
	var offset: float = rand_range(0, animation_player.current_animation_length)
	animation_player.advance(offset)


func _on_Tree_area_entered(area: Area2D) -> void:
	animation_player.queue("wind")


func _on_Tree_area_exited(area: Area2D) -> void:
	animation_player.queue("idle")
