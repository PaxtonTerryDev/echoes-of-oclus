class_name WorldState extends Resource

@export var id: String = UUID.generate()
@export var grid: WorldGrid = WorldGrid.new()

func reset() -> void:
	id = UUID.generate()
	grid = WorldGrid.new()
