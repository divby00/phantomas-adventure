extends Area2D

signal door_entered(door)

export var connection: Resource = null
export(String, FILE, "*.tscn") var next_map = ""

var active: bool = true


func _ready() -> void:
	Utils.connect_signal(self, "body_entered", self, "_on_body_entered")
	scale.x = 1 if position.x == 0 else -1
	if position.x != 0:
		position.x += 16


func _on_body_entered(_player: Node) -> void:
	if active:
		emit_signal("door_entered", self)
		print("Entered!")
		active = false
