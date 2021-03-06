extends Node2D

const Steps = preload("res://resources/sounds/intro-steps.wav")
const WorldScene: PackedScene = preload("res://scenes/World/World.tscn")

onready var timer: Timer = $Timer
onready var dialog: Node = $Dialog
onready var act_timer: Timer = $ActTimer
onready var music_tween: Tween = $MusicTween
onready var transition_in: CanvasLayer = $TransitionIn
onready var transition_out: CanvasLayer = $TransitionOut
onready var music_player: AudioStreamPlayer = $MusicPlayer
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var acts = [$ColorMessage, $ColorMessage2, $ColorMessage3, $ColorMessage4]
onready var menu_manager: MenuManager = $MenuManager

var current_act = 0


func _ready():
	transition_in.start()
	for act in acts:
		Utils.connect_signal(act, "message_removed", self, "_on_message_removed")
	Utils.connect_signal(dialog, "dialog_finished", self, "_on_dialog_finished")
	Utils.connect_signal(menu_manager, "menu_selected", self, "_on_menu_selected")
	Utils.connect_signal(transition_out, "finished", self, "_on_transition_out_finished")

	acts[current_act].start()
# warning-ignore:return_value_discarded
	music_tween.interpolate_property(music_player, "volume_db", 0, -80, 2.00, 1, Tween.EASE_IN, 0)


func _process(_delta):
	if menu_manager.is_visible():
		return

	if Input.is_action_just_pressed("Cancel") or Input.is_action_just_pressed("ui_cancel"):
		act_timer.paused = true
		dialog.pause(true)
		menu_manager.show_menu()


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
	SoundManager.play_se("IntroKnock")


func _on_message_removed(_act):
	if current_act == 4:
		act_timer.stop()


func _on_MusicTween_tween_completed(_object, _key):
	_dialog_start()


func _dialog_start():
	SoundManager.play_se("IntroWindowOpens")
	animation_player.play("animate")


func _on_AnimationPlayer_animation_finished(_anim_name):
	dialog.start()


func _on_dialog_finished(_dialog):
	transition_out.start()


func _on_transition_out_finished():
# warning-ignore:return_value_discarded
	GameSlotHandler.GameData.intro_viewed = true
	GameSlotHandler.update_slot()
	get_tree().change_scene_to(WorldScene)


func _on_menu_selected(menuitem):
	match menuitem.text:
		"INTRO_CHOICE_YES":
			menu_manager.hide_menu()
			dialog.pause(false)
			dialog.stop()
		"INTRO_CHOICE_NO":
			menu_manager.hide_menu()
			dialog.pause(false)
			act_timer.paused = false
