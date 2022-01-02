extends CanvasLayer

signal message_finished

export var character: String
export var messages: Array

onready var char_name = Characters.get_name(character)
onready var char_portrait = Characters.get_portrait(character)
onready var char_background = Characters.get_background(character)

onready var portrait: Sprite = $Portrait
onready var name_label: Label = $NameLabel
onready var glyph_timer: Timer = $GlyphTimer
onready var portrait_frame: Sprite = $PortraitFrame
onready var message_frame: NinePatchRect = $MessageFrame
onready var text_continue: AnimatedSprite = $TextContinue
onready var message_label: Label = $MessageFrame/MessageLabel
onready var portrait_background: Sprite = $PortraitBackground
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var audio_player_text: AudioStreamPlayer = $AudioStreamPlayerText

var current_glyph: int = 0
var current_message: int = 0
var wait_for_user: bool = false


func _ready():
	name_label.text = char_name
	message_label.text = ""
	portrait.texture = char_portrait
	portrait_background.texture = char_background


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and wait_for_user:
		if current_message < messages.size() - 1:
			current_message += 1
			current_glyph = 0
			text_continue.visible = false
			wait_for_user = false
			glyph_timer.start()
		else:
			animation_player.play("close")

	if Input.is_action_pressed("ui_accept") and not wait_for_user and !animation_player.is_playing():
		if current_glyph < messages[current_message].length() + 1:
			glyph_timer.stop()
			_print_glyph()
			glyph_timer.start()
		else:
			glyph_timer.stop()
			text_continue.playing = true
			text_continue.visible = true if current_message < messages.size() - 1 else false
			wait_for_user = true


func _print_glyph():
	message_label.text = messages[current_message].substr(0, current_glyph)
	audio_player_text.play()
	current_glyph += 1


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "open":
		glyph_timer.start()
	if anim_name == "close":
		emit_signal("message_finished", self)


func _on_GlyphTimer_timeout():
	if current_glyph < messages[current_message].length() + 1:
		_print_glyph()
	else:
		glyph_timer.stop()
		text_continue.playing = true
		text_continue.visible = true if current_message < messages.size() - 1 else false
		wait_for_user = true
