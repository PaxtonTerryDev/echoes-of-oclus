class_name SaveGameData extends Resource

@export var world_state: WorldStateResource

static func capture() -> SaveGameData:
	var data = SaveGameData.new()
	data.world_state = WorldState.save()
	return data
