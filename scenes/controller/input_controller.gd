extends Node

var gameplay: GameplayInputContext = GameplayInputContext.new()


func _physics_process(_delta: float) -> void:
	process_poll_schedules()


## WARN: This may be calling several times per frame, and could be looked at if it becomse a performance issue.  Basically it gets called for ALL inputs, including mouse movements, etc.
func _input(_event: InputEvent) -> void:
	process_event_schedules()


func process_poll_schedules() -> void:
	var t = InputAction.Type.POLL
	_process_schedule(gameplay, t)
	return


func process_event_schedules() -> void:
	var t = InputAction.Type.EVENT
	_process_schedule(gameplay, t)
	return


func _process_schedule(context: InputContext, type: InputAction.Type) -> void:
	if context.is_active():
		for action in context.schedule[type]:
			action.handle()
