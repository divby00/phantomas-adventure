extends KinematicBody2D


onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	Utils.connect_signal(hitbox, "collision", self, "_on_hitbox_collision")


func _on_hitbox_collision(damage):
	PlayerStats.health -= damage
