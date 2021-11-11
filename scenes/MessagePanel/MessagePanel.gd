extends CanvasLayer

signal message_finished

export var character: String
export var message: String

onready var char_name = Characters.get_name(character)
onready var char_portrait = Characters.get_portrait(character)
onready var char_background = Characters.get_background(character)

onready var portrait: Sprite = $Portrait
onready var name_label: Label = $NameLabel
onready var glyph_timer: Timer = $GlyphTimer
onready var portrait_frame: Sprite = $PortraitFrame
onready var message_frame: NinePatchRect = $MessageFrame
onready var message_label: Label = $MessageFrame/MessageLabel
onready var portrait_background: Sprite = $PortraitBackground
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var audio_player_spawn: AudioStreamPlayer = $AudioStreamPlayerSpawn
onready var audio_player_text: AudioStreamPlayer = $AudioStreamPlayerText

var current_glyph: int = 0


func _ready():
	name_label.text = char_name
	message_label.text = ''
	portrait.texture = char_portrait
	portrait_background.texture = char_background
	audio_player_spawn.play()
	

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		message_label.text = message
		glyph_timer.stop()


func _on_GlyphTimer_timeout():
	if current_glyph < message.length():
		message_label.text = message.substr(0, current_glyph)
		audio_player_text.play()
		current_glyph += 1
	else:
		message_label.text = message
		glyph_timer.stop()
		emit_signal("message_finished", self)
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'open':
		glyph_timer.start()
