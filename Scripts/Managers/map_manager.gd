extends MarginContainer

const DISTANCES: Array = [
	[000, 743, 657, 939],
	[743, 000, 278, 428],
	[657, 278, 000, 444],
	[939, 428, 444, 000]
]

@export var _icon : Texture2D
@onready var _file: PopupMenu = %File
@onready var _ship: MarginContainer = %Ship
@onready var _days: Label = $VBoxContainer/Map/MarginContainer/Days
@onready var _embark: Button = $VBoxContainer/Map/MarginContainer/Embark
var _destination : int = -1

func _ready() -> void:
	get_parent().set_tab_icon(0, _icon)

func set_destination(toggled_on: bool, port_id: int) -> void:
	if toggled_on:
		_destination = port_id
	elif port_id == _destination:
		_destination = -1
	if _destination == -1 or _destination == _file.data.port:
		_days.visible = false
		_embark.disabled = true
	else:
		_days.text = str(ceil(DISTANCES[_file.data.port][_destination] / _ship.get_speed())) + " days"
		_days.visible = true
		_embark.disabled = false
