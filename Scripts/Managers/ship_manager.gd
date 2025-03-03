extends MarginContainer

const SHIP_NAMES : Array[String] = [
	"Serentiy",
	"Liberty",
	"Escape",
	"Blue Moon",
	"Spirit",
	"Destiny",
	"Carpe Diem",
	"Serendipity",
	"Relentless"
]

@export var _ships : Array[Ship]
@onready var _file: PopupMenu = %File
@onready var _my_ship_image: TextureRect = $"My Ship Info/VBoxContainer/TextureRect"
@onready var _my_ship_name_value: LineEdit = $"My Ship Info/VBoxContainer/Stats/Name Value"
@onready var _my_ship_type_value: Label = $"My Ship Info/VBoxContainer/Stats/Type Value"
@onready var _my_ship_crew_value: Label = $"My Ship Info/VBoxContainer/Stats/Crew Value"
@onready var _my_ship_cargo_value: Label = $"My Ship Info/VBoxContainer/Stats/Cargo Value"
var _my_ship : int

func _update_my_ship_info() -> void:
	_my_ship_image.texture = _ships[_my_ship].image
	_my_ship_name_value.text = _file.data.ship_name
	_my_ship_type_value.text = _ships[_my_ship].type
	_my_ship_crew_value.text = str(_ships[_my_ship].min_crew) + " - " + str(_ships[_my_ship].max_crew)
	_my_ship_cargo_value.text = str(_ships[_my_ship].cargo) + " tons"

func _on_file_reset() -> void:
	_my_ship = _file.data.ship
	if not _file.data.ship_name:
		_file.data.ship_name = SHIP_NAMES[randi_range(0, SHIP_NAMES.size() - 1)]
	_update_my_ship_info()

func _on_name_value_text_submitted(new_text: String) -> void:
	if new_text:
		_file.data.ship_name = new_text
	else:
		_my_ship_name_value.text = _file.data.ship_name
	_my_ship_name_value.release_focus()
