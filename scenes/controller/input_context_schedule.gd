class_name InputContextSchedule extends RefCounted

var _context: InputContext

var _schedule: Dictionary[InputAction.Type, Array]= {
	InputAction.Type.POLL: [],
	InputAction.Type.EVENT: []
	}

func _init(context: InputContext) -> void:
	_context = context
	_create_schedule()

func _create_schedule() -> void:
	for action in _context.get_actions():
		_schedule[action.type].push_back(action)

func process(type: InputAction.Type) -> void:
	for action in _schedule[type]:
		action.handle()
