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
var key_exit = 16777217 setget set_key_exit

var save_slot = 1 setget set_save_slot
var locale = TranslationServer.get_locale() setget set_locale

func set_locale(value):
	if ['es','en'].has(value):
		locale = value
	else:
		locale = 'en'
	TranslationServer.set_locale(locale)
	save()

func set_save_slot(value):
	if (value<1):
		value=1
	if (value>3):
		value=3
	save_slot = value
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

func set_key_exit(value):
	key_exit = value
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
	config.set_value("control", "key_exit", self.key_exit)
	config.set_value("save","slot",self.save_slot)
	config.set_value("language","locale",self.locale)
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

		if not config.has_section_key("control", "key_down"):
			config.set_value("control", "key_down", self.key_down)
		else:
			self.key_down = config.get_value("control", "key_down", InputMap.get_action_list("Down")[0])

		if not config.has_section_key("control", "key_left"):
			config.set_value("control", "key_left", self.key_left)
		else:
			self.key_left = config.get_value("control", "key_left", InputMap.get_action_list("Left")[0])

		if not config.has_section_key("control", "key_right"):
			config.set_value("control", "key_right", self.key_right)
		else:
			self.key_right = config.get_value("control", "key_right", InputMap.get_action_list("Right")[0])

		if not config.has_section_key("control", "key_action"):
			config.set_value("control", "key_action", self.key_action)
		else:
			self.key_action = config.get_value("control", "key_action", InputMap.get_action_list("Action")[0])

		if not config.has_section_key("control", "key_inventory"):
			config.set_value("control", "key_inventory", self.key_inventory)
		else:
			self.key_inventory = config.get_value("control", "key_inventory", InputMap.get_action_list("Inventory")[0])

		if not config.has_section_key("control", "key_exit"):
			config.set_value("control", "key_exit", self.key_exit)
		else:
			self.key_exit = config.get_value("control", "key_exit", InputMap.get_action_list("Exit")[0])

	config.save(file_config)

