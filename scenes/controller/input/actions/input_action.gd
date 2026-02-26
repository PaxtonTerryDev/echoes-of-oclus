class_name InputAction extends Resource

enum Type {
	POLL,
	EVENT
	}

signal pressed(strength: float)
signal held(strength: float)
signal released()

@export var action: StringName
@export var type: Type

static func create(_action: StringName, _type: Type = Type.EVENT) -> InputAction:
	var input_action = InputAction.new()
	input_action.action = _action
	input_action.type = _type
	return input_action

func handle() -> void:
	if Input.is_action_just_pressed(action):
		pressed.emit(Input.get_action_strength(action))
	if Input.is_action_pressed(action) && !Input.is_action_just_pressed(action):
		held.emit(Input.get_action_strength(action))
	if Input.is_action_just_released(action):
		released.emit()

