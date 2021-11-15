extends CanvasLayer

const ThemeResource: Theme = preload("res://resources/theme.tres")
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
		var menu_panel = MenuPanelScene.instance()
		add_child(menu_panel)
		menu_panel.id = menu['id']
		var previous = menu['previous']
		if previous != null:
			menu_panel.previous = previous
		menu_panel.visible = false
		var entries = menu['entries']
		for entry in entries:
			if entry['type'] == 'button':
				var button = Button.new()
				menu_panel.vbox.add_child(button)
				button.text = entry['id']
				button.theme = ThemeResource
				if entry['method']:
					if entry['next']:
						Utils.connect_signal(button, 'pressed', self, entry['method'], [entry['next']])
					else:
						Utils.connect_signal(button, 'pressed', self, entry['method'])

#				menu_panel.margin_top = -(menu_panel.rect_size.y / 2)
#				menu_panel.margin_bottom = (menu_panel.rect_size.y / 2)
#				menu_panel.margin_left = -(menu_panel.rect_size.x / 2)
#				menu_panel.margin_right = (menu_panel.rect_size.x / 2)
#				var screen_size = Vector2(ProjectSettings.get("display/window/size/width"), ProjectSettings.get("display/window/size/height"))
#				var pos = Vector2((screen_size.x / 2 - menu_panel.rect_size.x / 2), (screen_size.y / 2 - menu_panel.rect_size.y / 2))
#				print(menu_panel.rect_size)
#				menu_panel.set_global_position(pos)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		var previous = selected_menu.previous
		if previous != '':
			self.current_menu = previous


func start():
	self.current_menu = 'main'
	set_process(true)


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


func get_current_menu():
	return current_menu
