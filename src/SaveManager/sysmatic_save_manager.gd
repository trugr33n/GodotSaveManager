extends Node

var save_template : Dictionary = {
	"name" : "",
	"time" : "",
	"stringed_data" : ""
}

func InitSave(name_value: String = "SSM_null_save") -> void:
	DirAccess.make_dir_absolute("user://"+name_value)
	var _fileController : FileAccess = FileAccess.open("user://"+name_value, FileAccess.WRITE)
	_fileController.store_var(save_template)
	
