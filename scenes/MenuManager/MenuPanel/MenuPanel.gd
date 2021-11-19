extends PanelContainer

const ThemeResource: Theme = preload("res://resources/theme.tres")
const Cursor: StreamTexture = preload("res://resources/sprites/menu-arrow.png")

export var id: String
export var previous: String
export var entries: Array

onready var vbox: VBoxContainer = $VBoxContainer

var first_node = null


func _ready() -> void:
	for entry in entries:
		if entry['type'] == 'button':
			_create_button(entry)


func _create_button(entry):
	var button = Button.new()
	vbox.add_child(button)
	button.text = entry['id']
	button.theme = ThemeResource
	if entry['method']:
		if entry['next']:
			Utils.connect_signal(button, 'pressed', get_node("../"), entry['method'], [entry['next']])
		else:
			Utils.connect_signal(button, 'pressed', get_node("../"), entry['method'])
	first_node = vbox.get_children()[0]
