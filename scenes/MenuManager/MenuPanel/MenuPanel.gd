extends PanelContainer

const ThemeResource: Theme = preload("res://resources/theme.tres")
const Cursor: StreamTexture = preload("res://resources/sprites/menu-arrow.png")

export var id: String
export var previous: String
export var entries: Array

onready var vbox: VBoxContainer = $VBoxContainer

var first_node = null
var can_change_key: bool = false
var selected_action: String = ''
var selected_button: Button = null

enum ACTIONS {
	Up, Down, Left, Right, Action
}


func _ready() -> void:
	var has_keypress: bool = false
	for entry in entries:
		if entry['type'] == 'button':
			_create_button(entry)
		if entry['type'] == 'check':
			_create_check(entry)
		if entry['type'] == 'slider':
			_create_slider(entry)
		if entry['type'] == 'hrule':
			_create_hrule()
		if entry['type'] == 'label':
			_create_label(entry)
		if entry['type'] == 'keypress':
			has_keypress = true
			_create_keypress(entry)

		if !has_keypress:
			first_node = vbox.get_children()[0]
		else:
			var hbox: HBoxContainer = vbox.get_children()[0]
			first_node = hbox.get_children()[1]


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if can_change_key:
			_change_key(event)
			can_change_key = false


func _create_button(entry):
	var button = Button.new()
	vbox.add_child(button)
	button.text = entry['id']
	button.theme = ThemeResource
	if entry['method']:
		if entry['next']:
			Utils.connect_signal(button, 'pressed', get_node("../../"), entry['method'], [entry['next']])
		else:
			Utils.connect_signal(button, 'pressed', get_node("../../"), entry['method'])


func _create_check(entry):
	var check = CheckBox.new()
	vbox.add_child(check)
	check.text = entry['id']
	check.theme = ThemeResource
	if entry['method']:
		Utils.connect_signal(check, 'pressed', get_node("../../"), entry['method'], [check])
	if entry['init_method']:
		call(entry['init_method'], check)


func _create_slider(entry):
	var slider = HSlider.new()
	vbox.add_child(slider)
	slider.theme = ThemeResource
	slider.step = 0.1
	slider.min_value = 0
	slider.max_value = 1
	if entry['method']:
		if entry['next']:
			Utils.connect_signal(slider, 'value_changed', get_node("../../"), entry['method'], [entry['next']])
		else:
			Utils.connect_signal(slider, 'value_changed', get_node("../../"), entry['method'], [slider])
	if entry['init_method']:
		call(entry['init_method'], slider)


func _create_hrule():
	var hrule = HSeparator.new()
	hrule.theme = ThemeResource
	vbox.add_child(hrule)


func _create_label(entry):
	var label = Label.new()
	label.theme = ThemeResource
	label.align = Label.ALIGN_CENTER
	label.text = entry['id']
	vbox.add_child(label)


func _create_keypress(entry):
	var hbox: HBoxContainer = HBoxContainer.new()
	hbox.size_flags_horizontal = SIZE_EXPAND_FILL
	hbox.size_flags_vertical = SIZE_EXPAND_FILL
	hbox.theme = ThemeResource
	var label: Label = Label.new()
	label.theme = ThemeResource
	label.text = entry['id']
	label.size_flags_horizontal = SIZE_EXPAND_FILL
	var button: Button = Button.new()
	button.theme = ThemeResource
	button.align = Label.ALIGN_RIGHT
	button.text = InputMap.get_action_list(entry['action'])[0].as_text()
	button.size_flags_horizontal = SIZE_EXPAND_FILL
	button.toggle_mode = true
	button.pressed = false
	button.add_to_group("KeyButtonsGroup")
	Utils.connect_signal(button, "pressed", self, "_on_redefine_button_pressed", [entry, button])
	hbox.add_child(label)
	hbox.add_child(button)
	vbox.add_child(hbox)
	if entry['init_method']:
		call(entry['init_method'], entry['action'])


func _init_fullscreen_checkbox(checkbox):
	Configuration.load_and_save_config()
	checkbox.pressed = Configuration.fullscreen


func _init_sfx_slider(slider):
	slider.value = Configuration.sfx_volume


func _init_music_slider(slider):
	slider.value = Configuration.music_volume


func _init_control(action):
	var button: Button = _find_key_button(action)
	var scancode = -1
	match action:
		"Up": scancode = Configuration.key_up
		"Down": scancode = Configuration.key_down
		"Left": scancode = Configuration.key_left
		"Right": scancode = Configuration.key_right
		"Action": scancode = Configuration.key_action
	_init_input_map(button, scancode, action)


func _find_key_button(action):
	var button: Button = null
	var buttons = get_tree().get_nodes_in_group("KeyButtonsGroup")
	for btn in buttons:
		var btn_label = OS.get_scancode_string(InputMap.get_action_list(action)[0].scancode)
		if btn.text == btn_label:
			button = btn
			break
	return button


func _init_input_map(button, scancode, action):
	InputMap.action_erase_events(action)
	var event = InputEventKey.new()
	event.scancode = scancode
	InputMap.action_add_event(action, event)
	button.text = OS.get_scancode_string(scancode)


func _reset_buttons(button: Button):
	var buttons: Array = get_tree().get_nodes_in_group("KeyButtonsGroup")
	for btn in buttons:
		if button != btn:
			btn.set_pressed(false)


func _change_key(new_key):
	var scancode: int = new_key.scancode
	var scancode_label: String = OS.get_scancode_string(scancode)

	if !InputMap.get_action_list(selected_action).empty():
		InputMap.action_erase_events(selected_action)

	for action in ACTIONS:
		if InputMap.action_has_event(action, new_key):
			InputMap.action_erase_event(action, new_key)

	InputMap.action_add_event(selected_action, new_key)
	selected_button.text = scancode_label
	match selected_action:
		"Up": Configuration.key_up = scancode
		"Down": Configuration.key_down = scancode
		"Left": Configuration.key_left = scancode
		"Right": Configuration.key_right = scancode
		"Action": Configuration.key_action = scancode


func _on_redefine_button_pressed(entry, button: Button):
	_reset_buttons(button)
	selected_action = entry['action']
	selected_button = button
	can_change_key = button.is_pressed()
