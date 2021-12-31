extends Node

const SaveGame = preload("res://scripts/SaveGame.gd")
const SAVE_NAME_TEMPLATE: String = "save_%03d.tres"


func save(slot_id: int) -> void:
	var save_game = SaveGame.new()
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
