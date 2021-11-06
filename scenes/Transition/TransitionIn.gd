extends CanvasLayer

signal transition_in_finished

onready var timer = $Timer
onready var texture_rect = $TextureRect


func start():
	timer.start()
	var animated_texture: AnimatedTexture = texture_rect.texture
	animated_texture.current_frame = 0
	texture_rect.visible = true


func _on_Timer_timeout():
	emit_signal("transition_in_finished")
