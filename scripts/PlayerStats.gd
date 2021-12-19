extends Node

signal player_destroyed
signal health_changed(health)


export var MAX_HEALTH: int = 141

var health = MAX_HEALTH setget set_health


func set_health(value):
	health = clamp(value, -2, MAX_HEALTH)
	if health == -2:
		emit_signal("player_destroyed")
	else:
		emit_signal("health_changed", health)
