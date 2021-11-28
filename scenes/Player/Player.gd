extends KinematicBody2D


onready var animation_player = $AnimationPlayer

export (int) var speed = 120
export (int) var jump_speed = -180
export (int) var gravity = 90

var velocity = Vector2.ZERO
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("fall")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if velocity.y == 0:
		animation_player.play("walk")

#	if Input.is_action_just_pressed("jump"):
#		if is_on_floor():
#			velocity.y = jump_speed
