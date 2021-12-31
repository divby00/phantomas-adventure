extends Node2D

const Steps = preload("res://resources/sounds/intro-steps.wav")
const WorldScene: PackedScene = preload("res://scenes/World/World.tscn")

onready var timer: Timer = $Timer
onready var dialog: Node = $Dialog
onready var act_timer: Timer = $ActTimer
onready var music_tween: Tween = $MusicTween
onready var sfx_player: AudioStreamPlayer = $SfxPlayer
onready var transition_in: CanvasLayer = $TransitionIn
onready var transition_out: CanvasLayer = $TransitionOut
onready var music_player: AudioStreamPlayer = $MusicPlayer
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var acts = [$ColorMessage, $ColorMessage2, $ColorMessage3, $ColorMessage4]

var current_act = 0


func _ready():
	transition_in.start()
	for act in acts:
		Utils.connect_signal(act, "message_removed", self, "_on_message_removed")
	Utils.connect_signal(dialog, "dialog_finished", self, "_on_dialog_finished")
	acts[current_act].start()
# warning-ignore:return_value_discarded
	music_tween.interpolate_property(music_player, "volume_db", 0, -80, 2.00, 1, Tween.EASE_IN, 0)


func _on_Timer_timeout():
	timer.stop()
	act_timer.start()


func _on_ActTimer_timeout():
	_change_act()


func _change_act():
	acts[current_act].remove()

	if current_act < acts.size() - 1:
		current_act += 1
		act_timer.stop()
		timer.start()
		acts[current_act].start()
	else:
# warning-ignore:return_value_discarded
		music_tween.start()
		current_act += 1


func _play_step():
	sfx_player.stream = Steps
	sfx_player.play()


func _on_message_removed(_act):
	if current_act == 4:
		act_timer.stop()


func _on_MusicTween_tween_completed(_object, _key):
	_dialog_start()


func _dialog_start():
	sfx_player.play()
	animation_player.play("animate")


func _on_AnimationPlayer_animation_finished(_anim_name):
	dialog.start()


func _on_dialog_finished(_dialog):
	transition_out.start()


func _on_TransitionOut_transition_out_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(WorldScene)
