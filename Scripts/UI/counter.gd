extends HBoxContainer

@export var _resource_name : String
@export var _maximum : int = 1000
@onready var _file: PopupMenu = %File
@onready var _label: Label = $Label
var _quantity : int

func receive(amount : int) -> void:
	_quantity = _file.data.get(_resource_name)
	_quantity = min(_quantity + amount, _maximum)
	update_counter()
	_file.data.set(_resource_name, _quantity)

func spend(amount : int) -> bool:
	_quantity = _file.data.get(_resource_name)
	if _quantity < amount:
		return false
	_quantity -= amount
	update_counter()
	_file.data.set(_resource_name, _quantity)
	return true

func update_counter() -> void:
	_label.text = str(_file.data.get(_resource_name))

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_up"):
		#receive(randi_range(1, 100))
	#if event.is_action_pressed("ui_down"):
		#print(spend(randi_range(1, 100)))
