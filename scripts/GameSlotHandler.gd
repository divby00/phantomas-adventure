extends Node

const SAVE_NAME_TEMPLATE: String = "saveslot_%03d.tres"

onready var EncryptKey:String = OS.get_unique_id()
onready var GameVersion:String = ProjectSettings.get_setting("application/config/version")
var GameData:Dictionary = {}
var _current_slot = 0

func set_slot(slot_id:int):
	_current_slot = slot_id
	if (!_load_slot(_current_slot)):
		init_slot()

func init_slot() -> bool:
	self.GameData = GameSlotData.get_empty_slotdata()
	self.GameData.game_version = GameVersion
	self.GameData.intro_viewed = false
	if (!_save_slot(_current_slot)):
		_remove_slot(_current_slot)
		return false
	return true

func update_slot() -> bool:
	if (GameData!=null):
		return _save_slot(_current_slot)
	else:
		return false

func exists_slot(slot_id:int) -> bool:
	var slot_path: String = _get_slot_path(slot_id)
	var file: File = File.new()
	return file.file_exists(slot_path)

func _get_slot_path(slot_id:int) -> String:
	return "user://" + SAVE_NAME_TEMPLATE % slot_id

func _remove_slot(slot_id:int):
	var slot_path: String = _get_slot_path(slot_id)
	var dir = Directory.new()
	dir.remove(slot_path)
	
func _save_slot(slot_id) -> bool:
	var slot_path: String = _get_slot_path(slot_id)
	var done:bool = false
	var f = File.new()
	var err = f.open_encrypted_with_pass(slot_path, File.WRITE, EncryptKey)
	if err == OK:
		f.store_var(self.GameData)
		done=true
	f.close()
	return done
	
func _load_slot(slot_id) -> bool:
	var slot_path: String = _get_slot_path(slot_id)
	var done:bool = false
	if (!exists_slot(slot_id)):
		return false		
	var f = File.new()
	var err = f.open_encrypted_with_pass(slot_path, File.READ, EncryptKey)
	if err == OK:
		self.GameData = f.get_var()
		done = (self.GameData.game_version <= GameVersion)
	f.close()
	
	if (!done):
		self.GameData = GameSlotData.get_empty_slotdata()
	return done


""""
func save(slot_id: int) -> void:
	var save_game = GameSlotData.new()
	save_game.game_version = ProjectSettings.get_setting("application/config/version")
	for node in get_tree().get_nodes_in_group("SaveGroup"):
		node.save(save_game)
	var save_path: String = "user://" + SAVE_NAME_TEMPLATE % slot_id
	var error: int = ResourceSaver.save(save_path, save_game)
	if error != OK:
		print("Unable to write the file %s to %s", [slot_id, save_path])

func load(slot_id: int) -> void:
	var load_path: String = "user://" + SAVE_NAME_TEMPLATE % slot_id
	var file: File = File.new()
	if not file.file_exists(load_path):
		print("Save file %s doesn't exist" % load_path)
		return
	var save_game: Resource = load(load_path)
	for node in get_tree().get_nodes_in_group("SaveGroup"):
		node.load(save_game)
"""
