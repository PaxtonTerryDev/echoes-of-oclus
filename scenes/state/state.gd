extends Node

@export var world: WorldState

func save() -> GameState:
	return GameState.create(world)
