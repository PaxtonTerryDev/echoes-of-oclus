class_name WorldStateResource extends Resource

@export var id: String

static func create(_id: String) -> WorldStateResource:
	var world_state_resource = WorldStateResource.new()
	world_state_resource.id = _id
	return world_state_resource
