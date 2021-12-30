extends Area2D

signal finished(wind)

var speed: float = 0.0


func _ready() -> void:
	speed = rand_range(150, 300)
	position = Vector2(544, 224)


func _process(delta: float) -> void:
	position.x -= delta * speed
	if position.x <= -128:
		emit_signal("finished", self)
