extends Node

@export var world: WorldState = WorldState.new()

func save() -> GameState:
	return GameState.create(world)

func restore(gs: GameState) -> void:
	world = gs.world
