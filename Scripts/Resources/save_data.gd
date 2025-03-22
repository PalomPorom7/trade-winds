class_name SaveData extends Resource

@export var mute : bool
@export var difficulty : int
@export var gold : int
@export var crew : Dictionary
@export var ship : int
@export var ship_name : String

func _init() -> void:
	gold = 100
	crew = {
		"Captain" : {"name" : "James", "pay" : 0},
		"Navigator" : {"name" : "Billy", "pay" : 5},
		"Helmsman" : {"name" : "Joe", "pay" : 3},
		"Topman" : [{"name" : "Bob", "pay" : 2}, {"name" : "Anne", "pay" : 2}],
		"Seaman" : [{"name" : "Sue", "pay" : 1}, {"name" : "Josephine", "pay" : 1}]
	}
	ship = 0
