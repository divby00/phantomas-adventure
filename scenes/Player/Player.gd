extends KinematicBody2D


const BombScene: PackedScene = preload("res://scenes/Player/Bomb/Bomb.tscn")

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var raycast = $RayCast2D
onready var jumping_y: int = global_position.y


var jumping: bool = false
var facing = Enums.FACING.RIGHT
var motion: Vector2 = Vector2.ZERO

# Technologies
var jump_control = false
var double_jump = false
var bomb = true
var phantom = false


func _physics_process(delta):
	if bomb and Input.is_action_just_pressed("Action"):
		_set_bomb()
	var input_vector: Vector2 = _get_input_vector()
	_apply_horizontal_force(input_vector, delta)
	_apply_friction(input_vector)
	_apply_gravity(delta)
	_jump_check(input_vector, delta)
	_update_animation(input_vector)
	move_and_slide(motion, Vector2.UP)


func _get_input_vector():
	var input_vector: Vector2 = Vector2.ZERO
	if jump_control or not jumping:
		input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		if input_vector.x > 0:
			facing = Enums.FACING.RIGHT
		elif input_vector.x < 0:
			facing = Enums.FACING.LEFT
	if jumping and not jump_control:
		input_vector.x = 1 if facing == Enums.FACING.RIGHT else -1
	return input_vector


func _apply_horizontal_force(input_vector, delta):
	if input_vector.x != 0:
		motion.x += input_vector.x * Constants.ACCELERATION * delta
		motion.x = clamp(motion.x, -Constants.MAX_SPEED, Constants.MAX_SPEED)


func _apply_friction(input_vector):
	if input_vector.x == 0:
		motion.x = lerp(motion.x, 0, Constants.FRICTION)


func _apply_gravity(delta):
	motion.y += Constants.GRAVITY * delta
	motion.y = min(motion.y, Constants.JUMP_FORCE)


func _jump_check(_input_vector, _delta):
	if is_on_floor():
		jumping = false
		jumping_y = global_position.y
		if Input.is_action_just_pressed("Up"):
			jumping = true
			motion.y = -Constants.JUMP_FORCE
		if Input.is_action_just_pressed("Down"):
			jumping = true
			motion.y = -(Constants.JUMP_FORCE/5) * 4
	else:
		if Input.is_action_just_released("Up") and motion.y < -Constants.JUMP_FORCE/2:
			jumping = true
			motion.y = -Constants.JUMP_FORCE/2


func _update_animation(input_vector):
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x)

	if is_on_floor():
		if input_vector.x != 0:
			animation_player.play("walk")
		else:
			animation_player.play("stand")
	else:
		if jumping and floor(global_position.y) <= jumping_y:
			animation_player.play("jump")
		else:
			animation_player.play("fall")
			motion.x /= 2


func _set_bomb():
	bomb = BombScene.instance()
	bomb.facing = facing
	get_tree().current_scene.add_child(bomb)
	bomb.set_global_position(Vector2(global_position.x + 8, global_position.y + 8))

