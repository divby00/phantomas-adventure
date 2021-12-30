extends CanvasLayer


const MESSAGES: Array = [
	"2022 M.A Software + Love4Retro",
	"Program by:", "Miguel Ángel Jiménez & Jesús Chicharro",
	"Graphics by:", "Jesús Chicharro",
	"Music by:", "Miguel Ángel Jiménez",
	"This is free software",
	"We hope you enjoy it!",
]

onready var label: Label = $Label
onready var tween: Tween = $Tween
onready var timer: Timer = $Timer

var message_index: int = 0


func _ready() -> void:
	label.text = MESSAGES[message_index]
	label.rect_position.x = -192
	_start_tween()


func _start_tween():
	label.rect_position.x = -192
	label.text = MESSAGES[message_index]
	tween.interpolate_property(label, "rect_position", Vector2(-192, 256), Vector2(384, 256), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_step(_object: Object, _key: NodePath, _elapsed: float, _value: Object) -> void:
	if round(label.rect_position.x) in [95, 96, 97]:
		label.rect_position.x = 96
		tween.stop(label, "rect_position")
		timer.start()


func _on_Tween_tween_all_completed() -> void:
	message_index += 1
	if message_index >= MESSAGES.size():
		message_index = 0
	_start_tween()


func _on_Timer_timeout() -> void:
	tween.resume(label, "rect_position")
