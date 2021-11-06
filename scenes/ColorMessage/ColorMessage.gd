tool
extends Node2D

signal remove
signal act_finished

export var message: String;
export var speed: float = 0.5;

const ColorGlyphScene: PackedScene = preload("res://scenes/ColorMessage/ColorGlyph.tscn")
const AsepriteFont: DynamicFont = preload("res://resources/fonts/aseprite.tres")

onready var label: Label = $Label
onready var timer: Timer = $Timer

var cursor_position: int = 0;
var character_position: Vector2 = Vector2.ZERO
var characters_buffer: PoolByteArray = []


func _ready():
	if Engine.editor_hint:
		label.text = "ColorMessage"
	characters_buffer = message.to_ascii()
	var label_length: int = 0
	for index in characters_buffer.size():
		label_length += _get_glyph_size(index)[0]
	var label_size: int = label_length / 2
	character_position.x = 240 - label_size


func start():
	timer.wait_time = speed
	timer.autostart = true
	timer.start()
	

func remove():
	emit_signal('remove')
	

func _on_Timer_timeout():
	var character = message.substr(cursor_position, 1)
	if cursor_position < message.length():
		var char_size = _get_glyph_size(cursor_position)
		_init_glyph(character, char_size)
	else:
		cursor_position = 0
		timer.stop()
	cursor_position += 1


func _init_glyph(character, char_size):
	var glyph = ColorGlyphScene.instance()
	Utils.connect_signal(self, "remove", glyph, "on_remove")
	glyph.character = character
	glyph.position = character_position
	add_child(glyph)
	glyph.start()
	character_position.x += char_size[0]


func _get_glyph_size(index):
	var current_character = int(characters_buffer[index])
	var next_character = int(characters_buffer[index + 1]) if index < message.length() - 1 else 0
	return AsepriteFont.get_char_size(current_character, next_character)
