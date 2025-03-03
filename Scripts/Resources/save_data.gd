class_name SaveData extends Resource

@export var mute : bool
@export var difficulty : int
@export var gold : int
@export var ship : int
@export var ship_name : String

func _init() -> void:
	gold = 100
	ship = 0
