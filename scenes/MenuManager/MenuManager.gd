extends CanvasLayer

const MenuPanelScene: PackedScene = preload("res://scenes/MenuManager/MenuPanel/MenuPanel.tscn")

export var config_file: String
export var current_menu: String = "main" setget set_current_menu, get_current_menu

var main_menu
var selected_menu
var menu_entries = []


func _ready():
	set_process(false)
	var json = Utils.json_file_read(config_file)
	menu_entries = json.result
	for menu in menu_entries:
		var entries = menu['entries']
		var menu_panel = MenuPanelScene.instance()
		menu_panel.entries = entries
		add_child(menu_panel)
		menu_panel.id = menu['id']
		var previous = menu['previous']
		if previous != null:
			menu_panel.previous = previous
		menu_panel.visible = false
		menu_panel.add_to_group("MenusGroup")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		var previous = selected_menu.previous
		if previous != '':
			self.current_menu = previous


func start():
	self.current_menu = 'main'
	set_process(true)


func _change_menu(new_menu_id):
	var menus = get_tree().get_nodes_in_group("MenusGroup")
	for menu in menus:
		if menu.id == new_menu_id:
			menu.first_node.grab_focus()


func _on_menu_main_start_selected():
	pass


func _on_menu_main_options_selected(params):
	self.current_menu = params


func _on_menu_main_quit_selected():
	get_tree().quit(0)


func _on_menu_options_graphics_selected(params):
	print(params)


func _on_menu_options_sounds_selected(params):
	print(params)


func set_current_menu(value):
	var menus = get_tree().get_nodes_in_group("MenuGroup")
	for menu in menus:
		menu.visible = false
		if menu.id == value:
			menu.visible = true
			selected_menu = menu
	current_menu = value
	_change_menu(current_menu)


func get_current_menu():
	return current_menu
