class_name WorldStateResource extends Resource

@export var id: String
@export var world_grid: WorldGrid

static func create(_id: String, _world_grid: WorldGrid) -> WorldStateResource:
	var world_state_resource = WorldStateResource.new()
	world_state_resource.id = _id
	world_state_resource.world_grid = _world_grid
	return world_state_resource
