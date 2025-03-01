class_name SaveData extends Resource

@export var mute : bool
@export var difficulty : int
@export var gold : int
@export var robots : int
#@export var name : String
#@export var time : float
#@export var favourite_color : Color
#@export var position : Vector2
#var temp # will not be saved

func _init() -> void:
	gold = 100
	robots = 1
	#name = "Jordan"
	#time = 12.5
	#favourite_color = Color(randf(), randf(), randf())
