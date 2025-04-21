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
@onready var _ports: Array[Node] = $VBoxContainer/Map/Ports.get_children()
@onready var _anchor: CheckButton = $VBoxContainer/HBoxContainer/Anchor
@onready var _sails: VSlider = $VBoxContainer/HBoxContainer/Sails
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

func _on_anchor_toggled(toggled_on: bool) -> void:
	_file.data.is_anchored = toggled_on

func _on_sails_value_changed(value: float) -> void:
	_file.data.sail = value

func _on_file_reset() -> void:
	_anchor.button_pressed = _file.data.is_anchored
	_sails.value = _file.data.sail
	for i in _ports.size():
		_ports[i].disabled = _file.data.port == i
		_ports[i].button_pressed = false
