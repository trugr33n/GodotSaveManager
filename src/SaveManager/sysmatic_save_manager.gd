extends Node

var save_template : Dictionary = {
	"name" : "",
	"time" : "",
	"stringed_data" : ""
}

var settings_template : Dictionary = {
	"window_mode" : "",
	"window_resolution" : {"x" : "", "y" : ""}
}

var current_loaded_dir : Dictionary

func InitSettings() -> void:
	var _settingsFile : FileAccess = FileAccess.open("user://settings.ini", FileAccess.WRITE)
	_settingsFile.store_var(settings_template)

func InitSave(name_value: String = "SSM_null_save") -> void:
	var dir : DirAccess = DirAccess.open("user://")
	dir.make_dir(name_value)
	CreateScreenshot(name_value)
	var _gameFile : FileAccess = FileAccess.open("user://"+name_value+"/game.ssm", FileAccess.WRITE)
	var json_string : String = JSON.stringify(save_template)
	_gameFile.store_line(json_string)

func LoadSave(name_value: String = "SSM_null_save") -> void:
	if !IsFileAlive("user://"+name_value+"/game.ssm"):
		return
	var _gameFile : FileAccess = FileAccess.open("user://"+name_value+"/game.ssm", FileAccess.READ)
	
	while _gameFile.get_position() < _gameFile.get_length():
		var json_string : String = _gameFile.get_line()
		var json : JSON = JSON.new()
		var parsed_result : int = json.parse(json_string)
		current_loaded_dir = json.data

func CreateScreenshot(name_value: String) -> void:
	var _screenshotPath : String = "user://"+name_value+"/preview.jpg"
	var image : Image = get_viewport().get_texture().get_image()
	image.save_jpg(_screenshotPath)
	save_template["preview"] = _screenshotPath

func IsFileAlive(path_value: String = "user://SSM_null_save/game.ssm") -> bool:
	return true if FileAccess.file_exists(path_value) else false
