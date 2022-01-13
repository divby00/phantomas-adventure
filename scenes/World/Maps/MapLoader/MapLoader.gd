extends Area2D

export var next_map: String = ""


func _on_MapLoader_body_entered(body: Node) -> void:
	if body != null and body.is_in_group("PlayerGroup"):
		# Activate level change
		print("Cambio!")
