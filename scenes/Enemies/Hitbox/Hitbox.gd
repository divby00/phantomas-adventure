extends Area2D

signal collision(damage)

export var damage: float

var collision: bool = false


func _process(delta: float) -> void:
	if collision:
		emit_signal("collision", damage)


func _on_Hitbox_body_entered(body: Node) -> void:
	collision = true


func _on_Hitbox_body_exited(body: Node) -> void:
	collision = false
