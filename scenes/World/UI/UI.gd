extends CanvasLayer

signal inventory_visible(visible)
signal gamemenu_visible(visible)
signal gamemenu_selected_option(option)

onready var life_bar: TextureProgress = $LifeBar
onready var tech_container: HBoxContainer = $TechContainer
onready var inventory = $InventoryPanel
onready var menu_manager:MenuManager = $MenuManager


func _ready():
	Utils.connect_signal(menu_manager, "menu_selected", self, "_on_menu_selected")
	Utils.connect_signal(menu_manager, "menu_init", self, "_on_menu_init")
	Utils.connect_signal(menu_manager, "key_redefined", self, "_on_key_redefined")


func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		if !inventory.visible:
			self.emit_signal("inventory_visible", true)
			inventory.open()
		else:
			inventory.close()
			self.emit_signal("inventory_visible", false)
		return

	if (Input.is_action_just_pressed("Cancel") or Input.is_action_just_pressed("ui_cancel")):
		if inventory.visible:
			inventory.close()
			self.emit_signal("inventory_visible", false)
		else:
			menu_manager.show_menu()
			self.emit_signal("gamemenu_visible", true)

func _on_menu_init(menu):
	Configuration.on_menu_init(menu)

func _on_menu_selected(menu):
	if menu.text=="MENU_MAIN_CONTINUEGAME":
		menu_manager.hide_menu()
		self.emit_signal("gamemenu_visible", false)
		return
	if menu.text=="MENU_CHOICE_EXIT_YES":
		menu_manager.hide_menu()
		self.emit_signal("gamemenu_selected_option", menu)
		return
		
	Configuration.on_menu_selected(menu)

func _on_key_redefined(action, keyevent):
	Configuration.on_key_redefined(action,keyevent)
