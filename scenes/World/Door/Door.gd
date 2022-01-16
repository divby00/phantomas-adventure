extends Area2D

signal door_entered(door)

enum ENTER_DIRECTION {LEFT,RIGHT}

export var id: String = ""
export var next_map: String = ""
export var next_door_id: String = ""
export var enter_direction: String = ""

onready var arrow = $Sprite
onready var colshape = $CollisionShape2D

func _ready() -> void:
	Utils.connect_signal(self, "body_entered", self, "_on_body_entered")
	if enter_direction == "RIGHT":
		arrow.scale.x = -1
		colshape.position.x = 12
	else:
		arrow.scale.x = 1
		colshape.position.x = 4

func _on_body_entered(_player: Node) -> void:
	emit_signal("door_entered", self)
		
