extends Panel

@onready var _fade: ColorRect = %Fade
@onready var _title_screen: Control = %"Title Screen"
@onready var _file: PopupMenu = %File

func _ready() -> void:
	_fade.show()
	_title_screen.show()
	_fade.to_clear()

func _on_start_pressed() -> void:
	%Start.disabled = true
	await _fade.to_black()
	_title_screen.hide()
	_file.new_game()
