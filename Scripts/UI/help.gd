extends PopupMenu

@onready var _about: PanelContainer = %About

func _on_id_pressed(id: int) -> void:
	match id:
		0:
			_about.show()
		2:
			if OS.get_name() == "HTML5":
				JavaScriptBridge.eval("window.location.href='https://www.patreon.com/TYanuziello'")
			else:
				OS.shell_open("https://www.patreon.com/TYanuziello")
