extends MarginContainer

@export var _icon : Texture2D
@export var _edit_icon : Texture2D
@onready var _file: PopupMenu = %File
@onready var _tree: Tree = $"HSplitContainer/My Crew/Tree"
var _tree_items : Dictionary

func _ready() -> void:
	get_parent().set_tab_icon(2, _icon)
	_tree.set_column_title(0, "Role")
	_tree.set_column_title(1, "Name")
	_tree.set_column_title(2, "Pay")
	_tree.set_column_expand(2, false)
	_populate_tree(_tree.get_child(0), null)
	_tree.get_root().set_editable(1, true)
	_tree.get_root().set_icon(1, _edit_icon)

func _populate_tree(current : Node, parent_tree_item : TreeItem) -> void:
	var x : int = current.name.find("x")
	var role : String = current.name
	var quantity : int = 1
	if x != -1:
		role = current.name.substr(0, x)
		quantity = int(current.name.substr(x + 1))
	var new_item : TreeItem = _add_tree_item(role, quantity, parent_tree_item)
	for child in current.get_children():
		_populate_tree(child, new_item)

func _add_tree_item(text : String, quantity : int, parent_tree_item : TreeItem) -> TreeItem:
	var new_item : TreeItem
	if quantity > 1:
		_tree_items[text] = []
	for i in quantity:
		new_item = _tree.create_item(parent_tree_item)
		new_item.set_text(0, text)
		new_item.visible = i == 0
		if quantity > 1:
			_tree_items[text].append(new_item)
		else:
			_tree_items[text] = new_item
	return new_item

func _populate_crew_member(role : TreeItem, crew_name : String, pay : String) -> void:
	role.set_text(1, crew_name)
	if role != _tree.get_root():
		if pay:
			role.set_cell_mode(2, TreeItem.CELL_MODE_RANGE)
			role.set_range_config(2, 1, 9, 1)
			role.set_range(2, float(pay))
			role.set_editable(2, true)
		else:
			role.set_cell_mode(2, TreeItem.CELL_MODE_STRING)
			role.set_text(2, pay)
			role.set_editable(2, false)

func _on_file_reset() -> void:
	for role in _tree_items:
		if _tree_items[role] is Array:
			var quantity : int = 0
			if _file.data.crew.has(role):
				quantity = _file.data.crew[role].size()
			for i in _tree_items[role].size():
				_tree_items[role][i].visible = i == 0 or i < quantity
				if i < quantity:
					_populate_crew_member(_tree_items[role][i], _file.data.crew[role][i]["name"], str(_file.data.crew[role][i]["pay"]))
				else:
					_populate_crew_member(_tree_items[role][i], "", "")
		else:
			if _file.data.crew.has(role):
				_populate_crew_member(_tree_items[role], _file.data.crew[role]["name"], str(_file.data.crew[role]["pay"]))
			else:
				_populate_crew_member(_tree_items[role], "", "")

func _on_tree_item_edited() -> void:
	var edited : TreeItem = _tree.get_edited()
	if edited == _tree.get_root():
		if edited.get_text(1):
			_file.data.crew["Captain"]["name"] = edited.get_text(1)
		else:
			edited.set_text(1, _file.data.crew["Captain"]["name"])
	else:
		for role in _tree_items:
			if _tree_items[role] is Array:
				for i in _tree_items[role].size():
					if _tree_items[role][i] == edited:
						_file.data.crew[role][i]["pay"] = int(edited.get_range(2))
			elif _tree_items[role] == edited:
				_file.data.crew[role]["pay"] = int(edited.get_range(2))
