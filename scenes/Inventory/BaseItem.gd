extends Area2D

signal on_item(item)

export var item_name: String

var collision: bool = false


func _process(_delta: float) -> void:
	if collision:
		emit_signal("on_item", self)


func _on_BaseItem_body_entered(_body: Node) -> void:
	collision = true


func _on_BaseItem_body_exited(_body: Node) -> void:
	collision = false
