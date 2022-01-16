extends Node

const file_config = "user://phmountains.cfg"

var fullscreen = false setget set_fullscreen
var sfx_volume = 0.5 setget set_sfx_volume
var music_volume = 0.5 setget set_music_volume
var key_up = 16777232 setget set_key_up
var key_down = 16777234 setget set_key_down
var key_left = 16777231 setget set_key_left
var key_right = 16777233 setget set_key_right
var key_action = 32 setget set_key_action
var key_inventory = 73 setget set_key_inventory
var key_cancel = 16777217 setget set_key_cancel

var save_slot = 1 setget set_save_slot
var locale = TranslationServer.get_locale() setget set_locale


func set_locale(value):
	if ["es", "en"].has(value):
		locale = value
	else:
		locale = "en"
	TranslationServer.set_locale(locale)
	save()


func set_save_slot(value):
	save_slot = clamp(value, 1, 3)
	GameSlotHandler.set_slot(save_slot)
	save()


func set_key_up(value):
	key_up = value
	save()


func set_key_down(value):
	key_down = value
	save()


func set_key_left(value):
	key_left = value
	save()


func set_key_right(value):
	key_right = value
	save()


func set_key_action(value):
	key_action = value
	save()


func set_key_inventory(value):
	key_inventory = value
	save()


func set_key_cancel(value):
	key_cancel = value
	save()


func set_fullscreen(value):
	if OS.get_name() != "HTML5":
		fullscreen = value
		if !fullscreen:
			OS.set_window_size(Vector2(1920, 1080))
		OS.window_fullscreen = fullscreen
		save()


func set_sfx_volume(value):
	sfx_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(sfx_volume))
	save()


func set_music_volume(value):
	music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(music_volume))
	save()


func save():
	var config = ConfigFile.new()
	config.set_value("display", "fullscreen", self.fullscreen)
	config.set_value("sound", "sfx_volume", self.sfx_volume)
	config.set_value("sound", "music_volume", self.music_volume)
	config.set_value("control", "key_up", self.key_up)
	config.set_value("control", "key_down", self.key_down)
	config.set_value("control", "key_left", self.key_left)
	config.set_value("control", "key_right", self.key_right)
	config.set_value("control", "key_action", self.key_action)
	config.set_value("control", "key_inventory", self.key_inventory)
	config.set_value("control", "key_cancel", self.key_cancel)
	config.set_value("save", "slot", self.save_slot)
	config.set_value("language", "locale", self.locale)
	config.save(file_config)


func load_and_save_config():
	var config = ConfigFile.new()
	var err = config.load(file_config)
	if err == OK:
		if not config.has_section_key("language", "locale"):
			config.set_value("language", "locale", self.locale)
		else:
			self.locale = config.get_value("language", "locale", TranslationServer.get_locale())

		if not config.has_section_key("save", "slot"):
			config.set_value("save", "slot", self.save_slot)
		else:
			self.save_slot = config.get_value("save", "slot", 1)
		GameSlotHandler.set_slot(self.save_slot)

		if not config.has_section_key("display", "fullscreen"):
			config.set_value("display", "fullscreen", self.fullscreen)
		else:
			self.fullscreen = config.get_value("display", "fullscreen", true)

		if not config.has_section_key("sound", "sfx_volume"):
			config.set_value("sound", "sfx_volume", self.sfx_volume)
		else:
			self.sfx_volume = config.get_value("sound", "sfx_volume", 0.5)

		if not config.has_section_key("sound", "music_volume"):
			config.set_value("sound", "music_volume", self.music_volume)
		else:
			self.music_volume = config.get_value("sound", "music_volume", 0.5)

		if not config.has_section_key("control", "key_up"):
			config.set_value("control", "key_up", self.key_up)
		else:
			self.key_up = config.get_value("control", "key_up", InputMap.get_action_list("Up")[0])
		_init_input_map("Up", self.key_up)

		if not config.has_section_key("control", "key_down"):
			config.set_value("control", "key_down", self.key_down)
		else:
			self.key_down = config.get_value("control", "key_down", InputMap.get_action_list("Down")[0])
		_init_input_map("Down", self.key_down)

		if not config.has_section_key("control", "key_left"):
			config.set_value("control", "key_left", self.key_left)
		else:
			self.key_left = config.get_value("control", "key_left", InputMap.get_action_list("Left")[0])
		_init_input_map("Left", self.key_left)

		if not config.has_section_key("control", "key_right"):
			config.set_value("control", "key_right", self.key_right)
		else:
			self.key_right = config.get_value("control", "key_right", InputMap.get_action_list("Right")[0])
		_init_input_map("Right", self.key_right)

		if not config.has_section_key("control", "key_action"):
			config.set_value("control", "key_action", self.key_action)
		else:
			self.key_action = config.get_value("control", "key_action", InputMap.get_action_list("Action")[0])
		_init_input_map("Action", self.key_action)

		if not config.has_section_key("control", "key_inventory"):
			config.set_value("control", "key_inventory", self.key_inventory)
		else:
			self.key_inventory = config.get_value("control", "key_inventory", InputMap.get_action_list("Inventory")[0])
		_init_input_map("Inventory", self.key_inventory)

		if not config.has_section_key("control", "key_cancel"):
			config.set_value("control", "key_cancel", self.key_cancel)
		else:
			self.key_cancel = config.get_value("control", "key_cancel", InputMap.get_action_list("Cancel")[0])
		_init_input_map("Cancel", self.key_cancel)

	config.save(file_config)


func _init_input_map(action, scancode):
	InputMap.action_erase_events(action)
	var event = InputEventKey.new()
	event.scancode = scancode
	InputMap.action_add_event(action, event)

func on_menu_init(menu):
	match menu.text:
		"MENU_GRAPHICS_FULLSCREEN":
			menu.check.pressed = Configuration.fullscreen
		"MENU_SOUNDS_SFX_VOLUME":
			menu.slider.value = Configuration.sfx_volume
		"MENU_SOUNDS_MUSIC_VOLUME":
			menu.slider.value = Configuration.music_volume
		"MENU_CONTROL_REDEFINE_UP":
			menu.button.text = OS.get_scancode_string(Configuration.key_up)
		"MENU_CONTROL_REDEFINE_DOWN":
			menu.button.text = OS.get_scancode_string(Configuration.key_down)
		"MENU_CONTROL_REDEFINE_LEFT":
			menu.button.text = OS.get_scancode_string(Configuration.key_left)
		"MENU_CONTROL_REDEFINE_RIGHT":
			menu.button.text = OS.get_scancode_string(Configuration.key_right)
		"MENU_CONTROL_REDEFINE_ACTION":
			menu.button.text = OS.get_scancode_string(Configuration.key_action)
		"MENU_CONTROL_REDEFINE_INVENTORY":
			menu.button.text = OS.get_scancode_string(Configuration.key_inventory)
		"MENU_CONTROL_REDEFINE_CANCEL":
			menu.button.text = OS.get_scancode_string(Configuration.key_cancel)


func on_menu_selected(menu):
	match menu.text:
		"MENU_GRAPHICS_FULLSCREEN":
			Configuration.fullscreen = menu.check.pressed
		"MENU_SOUNDS_SFX_VOLUME":
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(menu.slider.value))
			SoundManager.play_se("Blip")
			Configuration.sfx_volume = menu.slider.value
		"MENU_SOUNDS_MUSIC_VOLUME":
			Configuration.music_volume = menu.slider.value
		"LANG_ES":
			Configuration.locale = "es"
		"LANG_EN":
			Configuration.locale = "en"


func on_key_redefined(action, keyevent):
	match action:
		"Up":
			Configuration.key_up = keyevent.scancode
		"Down":
			Configuration.key_down = keyevent.scancode
		"Left":
			Configuration.key_left = keyevent.scancode
		"Right":
			Configuration.key_right = keyevent.scancode
		"Action":
			Configuration.key_action = keyevent.scancode
		"Inventory":
			Configuration.key_inventory = keyevent.scancode
		"Cancel":
			Configuration.key_cancel = keyevent.scancode
