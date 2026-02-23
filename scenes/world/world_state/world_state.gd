extends Node

@export var id: String = UUID.generate()

func save() -> WorldStateResource:
	return WorldStateResource.create(id)


func load(resource: WorldStateResource) -> void:
	id = resource.id


func reset() -> void:
	id = UUID.generate()
