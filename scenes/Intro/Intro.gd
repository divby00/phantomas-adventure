extends Node2D


const MainScene = preload("res://scenes/Main/Main.tscn")

onready var timer: Timer = $Timer
onready var act_timer: Timer = $ActTimer
onready var third_act: Array = [$ColorMessage6]
onready var second_act: Array = [$ColorMessage4, $ColorMessage5]
onready var first_act: Array = [$ColorMessage, $ColorMessage2, $ColorMessage3]
onready var transition_in: CanvasLayer = $TransitionIn
onready var transition_out: CanvasLayer = $TransitionOut

onready var acts = [
	first_act, second_act, third_act
]

var index: int = 0
var current_act = 0


func _ready():
	transition_in.start()
	acts[current_act][index].start()
	

func _on_Timer_timeout():
	if index < acts[current_act].size() - 1:
		index += 1
		acts[current_act][index].start()
	else:
		timer.stop()
		act_timer.start()


func _on_ActTimer_timeout():
	_change_act()


func _change_act():
	for paragraph in acts[current_act]:
		paragraph.remove()
	
	if current_act < acts.size() - 1:
		current_act += 1
		index = 0
		act_timer.stop()
		timer.start()
		acts[current_act][index].start()
	else:
		act_timer.stop()
		transition_out.start()


func _on_TransitionOut_transition_out_finished():
	get_tree().change_scene_to(MainScene)
