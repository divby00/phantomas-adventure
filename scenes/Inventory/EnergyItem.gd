extends "res://scenes/Inventory/BaseItem.gd"


func _on_EnergyItem_body_entered(_body: Node) -> void:
	PlayerStats.health += 10
	queue_free()
