extends Area2D

signal finished(wind)

var speed: float = 0.0


func _ready() -> void:
	speed = rand_range(30, 200)
	position = Vector2(528, 224)


func _process(delta: float) -> void:
	position.x -= delta * speed
	if position.x <= -64:
		emit_signal("finished", self)
