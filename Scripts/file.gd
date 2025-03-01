extends PopupMenu

const PATH : String = "user://save.tres"

@export var _new_shortcut : Shortcut
@export var _save_shortcut : Shortcut
@export var _load_shortcut : Shortcut
@export var _exit_shortcut : Shortcut
@onready var _fade: ColorRect = %Fade
var _busy : bool = true
var data : SaveData

signal reset

func _ready() -> void:
	if _new_shortcut:
		set_item_shortcut(0, _new_shortcut)
	if _save_shortcut:
		set_item_shortcut(1, _save_shortcut)
	if _load_shortcut:
		set_item_shortcut(2, _load_shortcut)
	if _exit_shortcut:
		set_item_shortcut(3, _exit_shortcut)

func _on_id_pressed(id: int) -> void:
	if _busy:
		return
	match id:
		0:
			new_game()
		1:
			save_game()
		2:
			load_game()
		3:
			exit_game()

func new_game() -> void:
	_busy = true
	await _fade.to_black()
	data = SaveData.new()
	reset.emit()
	await _fade.to_clear()
	_busy = false

func save_game() -> void:
	ResourceSaver.save(data, PATH) # There is only 1 ResourceSaver!

func load_game() -> void:
	_busy = true
	await _fade.to_black()
	data = ResourceLoader.load(PATH)
	reset.emit()
	await _fade.to_clear()
	_busy = false

func exit_game() -> void:
	_busy = true
	await _fade.to_black()
	get_tree().quit()
