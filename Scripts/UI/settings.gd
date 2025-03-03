extends PopupMenu

@onready var _difficulty: PopupMenu = $Difficulty
@onready var _file: PopupMenu = %File

func _ready() -> void:
	add_submenu_node_item(_difficulty.name, _difficulty)

func _on_id_pressed(id: int) -> void:
	if id == 0:
		_set_mute(not _file.data.mute)

func _set_mute(mute : bool) -> void:
	_file.data.mute = mute
	set("item_0/checked", mute)
	AudioServer.set_bus_mute(0, mute)

func _on_difficulty_id_pressed(id: int) -> void:
	_file.data.difficulty = id
	for item in _difficulty.item_count:
		_difficulty.set("item_%s/checked" % item, item == id)

func _on_file_reset() -> void:
	_set_mute(_file.data.mute)
	_on_difficulty_id_pressed(_file.data.difficulty)
