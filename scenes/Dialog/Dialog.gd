extends Node

signal dialog_finished

export var file: String

const MessageFont: DynamicFont = preload("res://resources/fonts/pixelphantom.tres")
const MessagePanelScene: PackedScene = preload("res://scenes/Dialog/MessagePanel/MessagePanel.tscn")
const max_line_width = 195
const max_lines = 3

var nodes: Array = []
var current_panel: int = 0
var message_panels: Array = []


func _ready():
	var path = "res://resources/i18n/dialogs/" + file
	var json = Utils.json_file_read(path)
	var locale = Configuration.locale
	match(locale):
		"es":
			locale="SPA"
		"en":
			locale="ENG"
	nodes = json.result[0]["nodes"]
	var messages = _get_messages()
	for message in messages:
		var character = message["character"][0]
		var text = message["text"][locale]
		var message_panel = MessagePanelScene.instance()
		Utils.connect_signal(message_panel, "message_finished", self, "_on_message_finished")
		message_panel.character = character
		message_panel.messages = _split_message(text)
		message_panels.append(message_panel)


func start():
	add_child(message_panels[current_panel])


func stop():
	emit_signal("dialog_finished", self)


func pause(p: bool):
	for mp in message_panels:
		if is_instance_valid(mp):
			mp.set_process(!p)

func _split_message(message):
	var messages: Array = []
	var tokens: Array = message.split(" ")
	var current_message: String = ""
	var current_line:String = ""
	var text_width:int = 0
	var lines:int = 0
	for token in tokens:
		text_width = MessageFont.get_string_size(current_line + " " + token).x
		if text_width > max_line_width:
			lines += 1
			if (current_message!=""):
				current_message+="\n"
			if lines >= max_lines:
				messages.append(current_message+current_line)
				current_message = ""
				current_line = ""
				lines=0
			else:
				current_message += current_line
			current_line = token
		else:
			current_line += " " + token	
	if (current_line!=""):
		if (current_message!=""):
			current_message+="\n"
		messages.append(current_message+current_line)					
	return messages


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
