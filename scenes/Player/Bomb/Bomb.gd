extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var particles: CPUParticles2D = $CPUParticles2D
onready var animation_player: AnimationPlayer = $AnimationPlayer

var started: bool = false
var facing = 0
var direction = 0
var motion: Vector2 = Vector2(0, Constants.THROW_FORCE)


func _ready() -> void:
	direction = -1 if facing == Enums.FACING.LEFT else 1


func _process(delta: float) -> void:
	if particles.emitting:
		started = true

	if not particles.emitting and started:
		queue_free()


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	motion = move_and_slide(motion, Vector2.UP)


func _apply_gravity(delta):
	motion.y += Constants.GRAVITY * delta
	motion.y = min(motion.y, Constants.ACCELERATION)
