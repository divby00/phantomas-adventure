extends Node2D

const BACKGROUND_SCROLL_SPEED: int = 12

const WorldScene: PackedScene = preload("res://scenes/World/World.tscn")
const WindScene: PackedScene = preload("res://scenes/TitleScreen/Wind/Wind.tscn")
const IntroScene: PackedScene = preload("res://scenes/Cutscenes/Intro/Intro.tscn")

onready var menu_manager = $MenuManager
onready var transition_in = $TransitionIn
onready var parallax = $ParallaxBackground
onready var transition_out = $TransitionOut
onready var wind_timer: Timer = $WindTimer

enum Destination { NEW_GAME, CONTINUE_GAME, EXIT }
var where_to_go = Destination.NEW_GAME


func _ready():
	Utils.connect_signal(transition_in, "transition_in_finished", self, "_on_transition_in_finished")
	Utils.connect_signal(transition_out, "transition_out_finished", self, "_on_transition_out_finished")
	Utils.connect_signal(menu_manager, "menu_selected", self, "_on_menu_selected")
	Utils.connect_signal(menu_manager, "menu_init", self, "_on_menu_init")
	Utils.connect_signal(menu_manager, "key_redefined", self, "_on_key_redefined")
	transition_in.start()
	_prepare_timer()


func _process(delta: float) -> void:
	# Animate background
	parallax.scroll_offset.x -= BACKGROUND_SCROLL_SPEED * delta


func _prepare_timer():
	wind_timer.wait_time = rand_range(.2, 1)


func _on_transition_in_finished():
	SoundManager.play_me("TitleSong")
	menu_manager.show_menu()
	transition_in.queue_free()


func _on_transition_out_finished():
	SoundManager.stop("TitleSong")
	match where_to_go:
		Destination.EXIT:
			get_tree().quit(0)  # Quit
		Destination.NEW_GAME:
			get_tree().change_scene_to(IntroScene)
		Destination.CONTINUE_GAME:
			get_tree().change_scene_to(WorldScene)


func _on_WindTimer_timeout() -> void:
	var wind = WindScene.instance()
	Utils.connect_signal(wind, "finished", self, "_on_wind_finished")
	get_tree().current_scene.add_child(wind)
	var y_position = randi() % 2
	wind.position.y = 250 if y_position == 0 else 184


func _on_wind_finished(wind):
	wind.queue_free()
	_prepare_timer()


func _on_menu_init(menu):
	match menu.text:
		"MENU_GRAPHICS_FULLSCREEN":
			menu.check.pressed = Configuration.fullscreen
		"MENU_SOUNDS_SFX_VOLUME":
			menu.slider.value = Configuration.sfx_volume
		"MENU_SOUNDS_MUSIC_VOLUME":
			menu.slider.value = Configuration.music_volume
		"MENU_SAVE_SLOT":
			menu.button.text = (TranslationServer.translate(menu.text) + ": #" + String(Configuration.save_slot))
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


func _on_menu_selected(menu):
	match menu.text:
		"MENU_MAIN_NEWGAME":
			if GameSlotHandler.GameData.intro_viewed:
				menu_manager.show_menu("overwritegame")
			else:
				where_to_go = Destination.NEW_GAME
				transition_out.start()
		"MENU_CHOICE_OVERWRITE_YES":
			GameSlotHandler.init_slot()
			where_to_go = Destination.NEW_GAME
			transition_out.start()
		"MENU_MAIN_CONTINUEGAME":
			if GameSlotHandler.GameData.intro_viewed:
				where_to_go = Destination.CONTINUE_GAME
			else:
				where_to_go = Destination.NEW_GAME
			transition_out.start()
		"MENU_MAIN_QUIT":
			where_to_go = Destination.EXIT
			transition_out.start()
		"MENU_GRAPHICS_FULLSCREEN":
			Configuration.fullscreen = menu.check.pressed
		"MENU_SOUNDS_SFX_VOLUME":
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(menu.slider.value))
			SoundManager.play_se("Blip")
			Configuration.sfx_volume = menu.slider.value
		"MENU_SOUNDS_MUSIC_VOLUME":
			Configuration.music_volume = menu.slider.value
		"MENU_SAVE_SLOT#1":
			Configuration.save_slot = 1
		"MENU_SAVE_SLOT#2":
			Configuration.save_slot = 2
		"MENU_SAVE_SLOT#3":
			Configuration.save_slot = 3
		"LANG_ES":
			Configuration.locale = "es"
		"LANG_EN":
			Configuration.locale = "en"


func _on_key_redefined(action, keyevent):
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
