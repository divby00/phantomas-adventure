extends Node

signal dialog_finished

export var file: String

const MessagePanelScene: PackedScene = preload("res://scenes/Dialog/MessagePanel/MessagePanel.tscn")

var nodes: Array = []
var message_panels: Array = []
var current_panel: int = 0


func _ready():
	var path = "res://resources/i18n/dialogs/" + file
	var json = Utils.json_file_read(path)
	nodes = json.result[0]["nodes"]
	var messages = _get_messages()
	for message in messages:
		var character = message['character'][0]
		var text = message['text']['ENG']
		var message_panel = MessagePanelScene.instance()
		Utils.connect_signal(message_panel, "message_finished", self, "_on_message_finished")
		message_panel.messages = text.split("{sep}")
		message_panel.character = character
		message_panels.append(message_panel)


func start():
	add_child(message_panels[current_panel])


func _get_messages():
	var start = _find_start_node()
	var next = start['next']
	var sorted_messages = []
	var messages = _find_message_nodes()
	for message in messages:
		var message_node = _find_next_message(next)
		sorted_messages.append(message_node)
		next = message_node['next']
	return sorted_messages


func _find_start_node():
	for node in nodes:
		if node['node_name'] == 'START':
			return node
	return null


func _find_message_nodes():
	for node in nodes:
		if node['node_name'] != 'START':
			return node
	return null


func _find_next_message(node_name):
	for node in nodes:
		if node['node_name'] == node_name:
			return node
	return null


func _on_message_finished(_message_panel):
	message_panels[current_panel].queue_free()
	current_panel += 1
	if current_panel < message_panels.size():
		add_child(message_panels[current_panel])
	else:
		emit_signal("dialog_finished", self)
