extends Node

@export var id: String = UUID.generate()

func save() -> WorldStateResource:
	return WorldStateResource.create(id)
