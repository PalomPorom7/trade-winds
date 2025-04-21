class_name SaveData extends Resource

@export var mute : bool
@export var difficulty : int
@export var gold : int
@export var crew : Dictionary
@export var ship : int
@export var ship_name : String
@export var port : int
@export var is_anchored : bool = true
@export var sail : float

func _init() -> void:
	gold = 100
	crew = {
		"Captain" : {"name" : "James", "pay" : 0},
		#"Navigator" : {"name" : "Billy", "pay" : 5},
		#"Helmsman" : {"name" : "Joe", "pay" : 3},
		"Topman" : [],
		"Seaman" : []
	}
	ship = 0
