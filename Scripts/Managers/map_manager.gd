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
@onready var _crew: MarginContainer = %Crew
@onready var _days: Label = $VBoxContainer/Map/MarginContainer/Days
@onready var _embark: Button = $VBoxContainer/Map/MarginContainer/Embark
@onready var _ports: Array[Node] = $VBoxContainer/Map/Ports.get_children()
@onready var _anchor: CheckButton = $VBoxContainer/HBoxContainer/Anchor
@onready var _sails: VSlider = $VBoxContainer/HBoxContainer/Sails
@onready var _progress: ProgressBar = $VBoxContainer/HBoxContainer/ProgressBar
var _destination : int = -1
var _is_sailing : bool
var _time_elapsed : float
var _days_at_sea : int

func _ready() -> void:
	get_parent().set_tab_icon(0, _icon)

func set_destination(toggled_on: bool, port_id: int) -> void:
	if _is_sailing:
		_ports[_destination].button_pressed = true
		return
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
		_progress.value = 0

func _on_anchor_toggled(toggled_on: bool) -> void:
	_file.data.is_anchored = toggled_on

func _on_sails_value_changed(value: float) -> void:
	_file.data.sail = value

func _on_embark_pressed() -> void:
	_is_sailing = true
	_time_elapsed = 0
	_days_at_sea = 0
	for i in range(1, 4):
		get_parent().set_tab_disabled(i, true)
	_progress.max_value = DISTANCES[_file.data.port][_destination]
	_embark.disabled = true

func _process(delta: float) -> void:
	if not _is_sailing or _file.data.is_anchored or _file.data.sail == 0:
		return
	_time_elapsed += delta
	if _time_elapsed > _days_at_sea:
		_days_at_sea += 1
		_crew.pay_out()
	_progress.value += _ship.get_speed() * _file.data.sail * delta
	if _progress.value >= _progress.max_value:
		_arrive_at_port(_destination)

func _arrive_at_port(port_id: int) -> void:
	_is_sailing = false
	_ports[_file.data.port].disabled = false
	_file.data.port = port_id
	_ports[_file.data.port].disabled = true
	_destination = -1
	for i in range(1, 4):
		get_parent().set_tab_disabled(i, false)

func _on_file_reset() -> void:
	_anchor.button_pressed = _file.data.is_anchored
	_sails.value = _file.data.sail
	for i in _ports.size():
		_ports[i].disabled = _file.data.port == i
		_ports[i].button_pressed = false
