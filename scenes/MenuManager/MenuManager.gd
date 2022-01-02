class_name MenuManager extends CanvasLayer

signal menu_selected(item)
signal menu_init(item)
signal key_redefined(action, keyevent)

const ThemeResource: Theme = preload("res://resources/theme.tres")

export var config_file: String
export var main_menu: String = "main"

onready var panel_container: PanelContainer = $CenterContainer/PanelContainer
onready var items_container: VBoxContainer = $CenterContainer/PanelContainer/ItemsContainer

var menu_definition
var menu_previous
var redefine_key = null


func show_menu(menu_id = ""):
	if menu_id == "":
		_build_menu(main_menu)
	else:
		_build_menu(menu_id)
	set_process(true)


func hide_menu():
	panel_container.visible = false
	_clear_items()
	set_process(false)


func is_visible():
	return panel_container.visible


func _ready():
	panel_container.visible = false
	set_process(false)
	var json = Utils.json_file_read(config_file)
	menu_definition = json.result


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if redefine_key:
			_redefine_key(event)
			redefine_key = null
		else:
			if Input.is_action_just_pressed("ui_cancel") && menu_previous != null && menu_previous != "":
				_build_menu(menu_previous)


func _redefine_key(new_key):
	var scancode: int = new_key.scancode
	var scancode_label: String = OS.get_scancode_string(scancode)
	InputMap.action_add_event(redefine_key.action, new_key)
	redefine_key.button.text = scancode_label
	redefine_key.button.pressed = false
	self.emit_signal("key_redefined", redefine_key.action, new_key)
	redefine_key = null
	new_key.pressed = false


func _build_menu(menu_id):
	var focus = false
	panel_container.visible = false
	_clear_items()
	var menu = menu_definition[menu_id]
	if menu.has("previous"):
		menu_previous = menu.previous
	else:
		menu_previous = null
	for entry in menu.entries:
		var item = _create_item(entry)
		items_container.add_child(item)
		if focus == false && ["button", "check", "slider", "keypress"].has(entry.type):
			if entry.type != "keypress":
				item.grab_focus()
			else:
				item.get_child(1).grab_focus()
			focus = true

	panel_container.visible = true


func _clear_items():
	while items_container.get_child_count() > 0:
		items_container.remove_child(items_container.get_child(0))


func _get_text_entry(entry) -> String:
	return entry.text


func _create_item(entry):
	match entry.type:
		"button":
			return _create_button(entry)
		"check":
			return _create_check(entry)
		"slider":
			return _create_slider(entry)
		"hrule":
			return _create_hrule(entry)
		"label":
			return _create_label(entry)
		"keypress":
			return _create_keypress(entry)


func _create_button(entry):
	var button = Button.new()
	entry.button = button
	button.text = _get_text_entry(entry)
	button.theme = ThemeResource
	self.emit_signal("menu_init", entry)
	Utils.connect_signal(button, "pressed", self, "_on_menu_selected", [entry])
	return button


func _create_check(entry):
	var check = CheckBox.new()
	entry.check = check
	check.text = _get_text_entry(entry)
	check.theme = ThemeResource
	check.add_color_override("font_color_pressed", Color.gold)

	self.emit_signal("menu_init", entry)
	Utils.connect_signal(check, "pressed", self, "_on_menu_selected", [entry])
	return check


func _create_slider(entry):
	var slider = HSlider.new()
	slider.theme = ThemeResource

	if entry.has("min"):
		slider.min_value = entry.min
	else:
		slider.min_value = 0

	if entry.has("max"):
		slider.max_value = entry.max
	else:
		slider.max_value = 1

	if entry.has("steps"):
		slider.step = entry.max / entry.steps
	else:
		slider.step = entry.max / 10

	entry.slider = slider
	self.emit_signal("menu_init", entry)
	Utils.connect_signal(slider, "value_changed", self, "_on_slider_changed", [entry])
	return slider


func _create_hrule(_entry):
	var hrule = HSeparator.new()
	hrule.theme = ThemeResource
	return hrule


func _create_label(entry):
	var label = Label.new()
	entry.label = label
	label.theme = ThemeResource
	label.align = Label.ALIGN_CENTER
	label.text = _get_text_entry(entry)
	self.emit_signal("menu_init", entry)
	return label


func _create_keypress(entry):
	var hbox: HBoxContainer = HBoxContainer.new()
	hbox.size_flags_horizontal = HBoxContainer.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = HBoxContainer.SIZE_EXPAND_FILL
	hbox.theme = ThemeResource
	var label: Label = Label.new()
	label.theme = ThemeResource
	label.text = _get_text_entry(entry)
	label.size_flags_horizontal = HBoxContainer.SIZE_EXPAND_FILL
	var button: Button = Button.new()
	button.theme = ThemeResource
	button.align = Label.ALIGN_RIGHT
	button.text = InputMap.get_action_list(entry.action)[0].as_text()
	button.size_flags_horizontal = HBoxContainer.SIZE_EXPAND_FILL
	button.toggle_mode = true
	button.pressed = false
	Utils.connect_signal(button, "pressed", self, "_on_redefine_key", [entry])
	hbox.add_child(label)
	hbox.add_child(button)
	entry.label = label
	entry.button = button
	self.emit_signal("menu_init", entry)
	return hbox


func _on_menu_selected(params):
	self.emit_signal("menu_selected", params)
	if params.has("menu"):
		_build_menu(params.menu)


func _on_slider_changed(_value, params):
	self.emit_signal("menu_selected", params)
	if params.has("menu"):
		_build_menu(params.menu)


func _on_redefine_key(params):
	params.button.add_color_override("font_color_pressed", Color.gold)
	redefine_key = params
