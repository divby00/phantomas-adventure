extends Node2D

## This class must be the parent class of every level scene.

var camera_limit_top: int = 0
var camera_limit_bottom: int = 0
var camera_limit_left: int = 0
var camera_limit_right: int = 0

# "id" will be "Rio" for Rio scene, "Dehesa" for Dehesa scene and so on...
var id: String = "BaseLevel"


func _ready() -> void:
	id = get_node(".").name
	var json_data: JSONParseResult = _read_ldtk_file()
	_read_camera_limits_from_ldtk(json_data)
	handle_map_changes()


func _read_ldtk_file() -> JSONParseResult:
	return Utils.json_file_read(Levels.Data[id].ldtk_file)


# Reads the camera limits directly from the ldtk file, the camera limits are set in World.gd thoug.
func _read_camera_limits_from_ldtk(json_data: JSONParseResult) -> void:
	if json_data.result is Dictionary:
		camera_limit_right = int(json_data.result.levels[0].pxWid)
		camera_limit_bottom = int(json_data.result.levels[0].pxHei)


# We need to handle the changes in the maps (for example removing the energy that has been taken previously).
# Currently children classes should override this method to handle these changes.
func handle_map_changes() -> void:
	pass
