extends KinematicBody2D


const GRAVITY: int = 200
const FRICTION: float = .5
const MAX_SPEED: int = 48
const ACCELERATION: int = 512
const JUMP_FORCE: float = 144.0

enum FACING {
	LEFT, RIGHT
}

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var jumping_y: int = global_position.y

var jumping: bool = false
var facing = FACING.RIGHT
var motion: Vector2 = Vector2.ZERO

# Technologies
var jump_control = false
var double_jump = false
var bomb = false
var phantom = false


func _physics_process(delta):
	var input_vector: Vector2 = _get_input_vector()
	_apply_horizontal_force(input_vector, delta)
	_apply_friction(input_vector)
	_apply_gravity(delta)
	_jump_check(input_vector, delta)
	_update_animation(input_vector)
	motion = move_and_slide(motion, Vector2.UP)


func _get_input_vector():
	var input_vector: Vector2 = Vector2.ZERO
	if jump_control or not jumping:
		input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		if input_vector.x > 0:
			facing = FACING.RIGHT
		elif input_vector.x < 0:
			facing = FACING.LEFT
	if jumping and not jump_control:
		input_vector.x = 1 if facing == FACING.RIGHT else -1
	return input_vector


func _apply_horizontal_force(input_vector, delta):
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)


func _apply_friction(input_vector):
	if input_vector.x == 0:
		motion.x = lerp(motion.x, 0, FRICTION)


func _apply_gravity(delta):
	motion.y += GRAVITY * delta
	motion.y = min(motion.y, JUMP_FORCE)


func _jump_check(_input_vector, _delta):
	if is_on_floor():
		jumping = false
		jumping_y = global_position.y
		if Input.is_action_just_pressed("Up"):
			jumping = true
			motion.y = -JUMP_FORCE
		if Input.is_action_just_pressed("Down"):
			jumping = true
			motion.y = -(JUMP_FORCE/5) * 4
	else:
		if Input.is_action_just_released("Up") and motion.y < -JUMP_FORCE/2:
			jumping = true
			motion.y = -JUMP_FORCE/2


func _update_animation(input_vector):
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x)

	if is_on_floor():
		if input_vector.x != 0:
			animation_player.play("walk")
		else:
			animation_player.play("stand")
	else:
		if jumping and global_position.y < jumping_y:
			animation_player.play("jump")
		else:
			animation_player.play("fall")
			motion.x /= 2
