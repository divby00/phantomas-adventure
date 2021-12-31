extends Node

signal dialog_finished

export var file: String

const MessageFont: DynamicFont = preload("res://resources/fonts/aseprite.tres")
const MessagePanelScene: PackedScene = preload("res://scenes/Dialog/MessagePanel/MessagePanel.tscn")

var nodes: Array = []
var current_panel: int = 0
var message_panels: Array = []


func _ready():
	var path = "res://resources/i18n/dialogs/" + file
	var json = Utils.json_file_read(path)
	nodes = json.result[0]["nodes"]
	var messages = _get_messages()
	for message in messages:
		var character = message["character"][0]
		var text = message["text"]["ENG"]
		var message_panel = MessagePanelScene.instance()
		Utils.connect_signal(message_panel, "message_finished", self, "_on_message_finished")
		message_panel.character = character
		message_panel.messages = _split_message(text)
		message_panels.append(message_panel)


func start():
	add_child(message_panels[current_panel])


func _split_message(message, max_length_per_line: int = 123):
	var line_length: int = 0
	var current_message: String = ""
	var messages: Array = []
	var tokens: Array = message.split(" ")
	var first_iter: bool = true
	for index in tokens.size():
		var token_length: int = _get_token_length(tokens[index])
		if token_length + line_length < max_length_per_line:
			line_length += token_length
			current_message += " " if not first_iter else ""
			current_message += tokens[index]
			# If we reach the end of the array append the message to the messages list
			if index >= tokens.size() - 1:
				messages.append(current_message.strip_edges())
			first_iter = false
		else:
			first_iter = true
			messages.append(current_message + " " + tokens[index].strip_edges())
			current_message = ""
			line_length = 0
			if messages.size() % 3 == 0 and index < tokens.size() - 1:
				var last_message: String = messages.pop_back()
				messages.append(last_message + "{sep}")

	var final_message: String = ""
	for msg in messages:
		final_message += msg
		if not "{sep}" in msg:
			final_message += "\n"

	return final_message.split("{sep}")


func _get_token_length(token: String) -> int:
	var length: int = 0
	var buffer: PoolByteArray = token.to_ascii()
	for index in buffer.size():
		var current_character: int = int(buffer[index])
		var next_character = int(buffer[index + 1]) if index < token.length() - 1 else 0
		length += MessageFont.get_char_size(current_character, next_character).x
	return length


func _get_messages():
	var start = _find_start_node()
	var next = start["next"]
	var sorted_messages = []
	var next_node = _find_next_message(next)
	while next_node != null:
		sorted_messages.append(next_node)
		next = next_node.next
		next_node = _find_next_message(next)
	return sorted_messages


func _find_start_node():
	for node in nodes:
		if node["node_name"] == "START":
			return node
	return null


func _find_message_nodes():
	return _find_start_node()


func _find_next_message(node_name):
	for node in nodes:
		if node["node_name"] == node_name:
			return node
	return null


func _on_message_finished(_message_panel):
	message_panels[current_panel].queue_free()
	current_panel += 1
	if current_panel < message_panels.size():
		add_child(message_panels[current_panel])
	else:
		emit_signal("dialog_finished", self)
