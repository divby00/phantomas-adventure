extends KinematicBody2D

const BombScene: PackedScene = preload("res://scenes/World/Player/Bomb/Bomb.tscn")

signal collision_cinematic(item)

onready var timer = $Timer
onready var sprite = $Sprite
onready var jumping_y: int = global_position.y
onready var animation_player = $AnimationPlayer
onready var phantom_collision = $Sprite/Area2D/CollisionShape2D

var jumping: bool = false
var phantom_possible: bool = false
var using_phantom: bool = false
var facing = Enums.FACING.RIGHT
var motion: Vector2 = Vector2.ZERO

# Technologies
var jump_control = true
var double_jump = true
var bomb = true
var phantom = true setget set_phantom


func _physics_process(delta):
	if bomb:
		_handle_bomb()
	if phantom:
		_handle_phantom()
	var input_vector: Vector2 = _get_input_vector()
	_apply_horizontal_force(input_vector, delta)
	_apply_friction(input_vector)
	_apply_gravity(delta)
	_jump_check(input_vector, delta)
	_update_animation(input_vector)
	move_and_slide(motion, Vector2.UP)


func _handle_bomb():
	if Input.is_action_just_pressed("Action"):
		_set_bomb()


func _handle_phantom():
	if not timer.is_stopped():
		if Input.is_action_just_pressed("Right") and facing == Enums.FACING.RIGHT and phantom_possible:
			using_phantom = true
			global_position.x += 32
		if Input.is_action_just_pressed("Left") and facing == Enums.FACING.LEFT and phantom_possible:
			using_phantom = true
			global_position.x -= 32


func _get_input_vector():
	var input_vector: Vector2 = Vector2.ZERO
	if jump_control or not jumping:
		input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		if input_vector.x > 0:
			facing = Enums.FACING.RIGHT
			timer.start()
		elif input_vector.x < 0:
			facing = Enums.FACING.LEFT
			timer.start()
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
			motion.y = -(Constants.JUMP_FORCE / 5) * 4
	else:
		if Input.is_action_just_released("Up") and motion.y < -Constants.JUMP_FORCE / 2:
			jumping = true
			motion.y = -Constants.JUMP_FORCE / 2


func _update_animation(input_vector):
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x)

	if using_phantom:
		var phantom_animation = "phantom-right" if facing == Enums.FACING.RIGHT else "phantom-left"
		animation_player.play(phantom_animation)
	else:
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


func _on_Area2D_body_entered(_body: Node) -> void:
	phantom_possible = false


func _on_Area2D_body_exited(_body: Node) -> void:
	phantom_possible = true


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "phantom-right" or anim_name == "phantom-left":
		using_phantom = false


func set_phantom(value):
	phantom_collision.disabled = !value
	phantom = value


func _on_Area2D_area_entered(area: Area2D):
	if area.get_collision_layer_bit(5):
		emit_signal("collision_cinematic", area)
