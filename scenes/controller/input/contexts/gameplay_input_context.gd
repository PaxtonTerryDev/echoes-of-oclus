class_name GameplayInputContext extends InputContext

@export var move_up: InputAction = InputAction.create("move_up", InputAction.Type.POLL)
@export var move_right: InputAction = InputAction.create("move_right", InputAction.Type.POLL)
@export var move_down: InputAction = InputAction.create("move_down", InputAction.Type.POLL)
@export var move_left: InputAction = InputAction.create("move_left", InputAction.Type.POLL)
@export var interact: InputAction = InputAction.create("interact", InputAction.Type.EVENT)
