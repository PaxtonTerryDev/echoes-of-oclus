class_name InputContext extends Resource 

signal activated()
signal deactivated()


@export var _active: bool = true


func is_active() -> bool:
	return _active


func activate() -> void:
	_active = true
	activated.emit()
	_activate()


func deactivate() -> void:
	_active = false
	deactivated.emit()
	_deactivate()


func _activate() -> void:
	return


func _deactivate() -> void:
	return


func _init() -> void:
	_initialize_actions()


var schedule: Dictionary[InputAction.Type, Array] = {
	InputAction.Type.POLL: [],
	InputAction.Type.EVENT: []
}


func _initialize_actions() -> void:
	for action in self.get_property_list():
		if action["hint_string"] == "InputAction":
			var a = self.get(action["name"]) as InputAction
			schedule[a.type].push_back(a)
