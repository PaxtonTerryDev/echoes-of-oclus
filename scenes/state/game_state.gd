class_name GameState extends Resource

@export var world: WorldState

static func create(world_state: WorldState) -> GameState:
	var game_state: GameState = GameState.new()
	game_state.world = world_state
	return game_state
