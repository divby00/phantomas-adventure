extends Area2D

signal door_entered(door)

enum ENTER_DIRECTION { LEFT, RIGHT }

export var id: String = ""
export var next_map: String = ""
export var next_door_id: String = ""
export var enter_direction: String = ""


func _ready() -> void:
	Utils.connect_signal(self, "body_entered", self, "_on_body_entered")
	if enter_direction == "RIGHT":
		scale.x = -1
		position.x += 17
	else:
		scale.x = 1


func _on_body_entered(_player: Node) -> void:
	emit_signal("door_entered", self)
