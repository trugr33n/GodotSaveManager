extends Control
class_name UI

static var _nextID : int = 0
var _fileName : String = "Savefile_index-"

@onready var _saveFoldersContainer : ItemList = $SaveFoldersContainer
@onready var _addButton : Button = $AddButton
@onready var _removeButton : Button = $RemoveButton
@onready var _inputScreen : InputScreen = $InputScreen
@onready var _outputScreen : OutputScreen = $OutputScreen


func _ready() -> void:
	if !SSM.IsFileAlive("user://settings.ini"):
		SSM.InitSettings()

func _process(delta: float) -> void:
	pass

func SaveInfoUpdate() -> void:
	SSM.save_template["name"] = _inputScreen._nameBox.text if !_inputScreen._nameBox.text.is_empty() else "Zero"
	SSM.save_template["time"] = _inputScreen._timeBox.text if !_inputScreen._timeBox.text.is_empty() else "Zero"
	SSM.save_template["stringed_data"] = _inputScreen._stringedDataBox.text if !_inputScreen._stringedDataBox.text.is_empty() else "Zero"

func OnAddButtonPressed() -> void:
	SaveInfoUpdate()
	SSM.InitSave(_fileName+str(_nextID))
	_saveFoldersContainer.add_item(SSM.save_template["name"])
	print(_fileName+str(_nextID))
	print(SSM.save_template)
	_nextID += 1

func SaveFoldersContainerItemSelected(index: int) -> void:
	SSM.LoadSave(_fileName+str(index))
	print(SSM.current_loaded_dir)
	
	_outputScreen._nameBox.text = SSM.current_loaded_dir["name"]
	_outputScreen._timeBox.text = SSM.current_loaded_dir["time"]
	_outputScreen._stringedDataBox.text = SSM.current_loaded_dir["stringed_data"]
