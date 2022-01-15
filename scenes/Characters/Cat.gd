extends Node2D


onready var animation_player: AnimationPlayer = $AnimationPlayer

const animations: Array = [
	"Idle", "Idle turning head", "Tongue", "Washing"
]


func _ready() -> void:
	randomize()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Tongue":
		animation_player.play("Washing")
	else:
		var next_animation: int = randi() % 3
		animation_player.play(animations[next_animation])
