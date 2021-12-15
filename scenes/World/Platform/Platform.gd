extends Node2D

signal is_over_platform(platform)


func _on_Area2D_body_entered(_body: Node) -> void:
	emit_signal("is_over_platform", true)


func _on_Area2D_body_exited(_body: Node) -> void:
	emit_signal("is_over_platform", false)
