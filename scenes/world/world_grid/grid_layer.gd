class_name GridLayer extends Resource

@export var offset_x: int
@export var offset_y: int
@export var cell_size: int

const ALLOWED_CELL_SIZES_AND_OFFSETS: Array[int] = [0, 2, 4, 6, 8, 16, 32, 64, 128, 256]

static func create(_cell_size: int, _offset_x: int = 0, _offset_y: int = 0) -> GridLayer:
	_validate(_cell_size, _offset_x, _offset_y)
	var grid_layer: GridLayer = GridLayer.new()
	grid_layer.cell_size = _cell_size
	return grid_layer

static func _validate(_cell_size: int, _offset_x: int = 0, _offset_y: int = 0) -> void:
	assert(ALLOWED_CELL_SIZES_AND_OFFSETS.has(_cell_size), "invalid cell size")
	assert(_cell_size != 0, "cell size cannot be 0")
	assert(ALLOWED_CELL_SIZES_AND_OFFSETS.has(_offset_x) && ALLOWED_CELL_SIZES_AND_OFFSETS.has(_offset_y), "invalid offset")

## Stores any variant data in a particular cell.  Cell coordinates are hashed
var data: Dictionary = {}

func _hash_coord(x: int, y: int) -> int:
	return (x & 0xFFFFFFFF) | ((y & 0xFFFFFFFF) << 32)

func get_cell(x: int, y: int) -> Dictionary:
	var cell_data = data.get(_hash_coord(x, y))
	return cell_data if cell_data != null else {}

func set_cell(x: int, y: int, cell_data: Dictionary) -> void:
	data[_hash_coord(x, y)] = cell_data

func del_cell(x: int, y: int) -> void:
	data.erase(_hash_coord(x, y))

func has_cell(x: int, y: int) -> bool:
	return data.has(_hash_coord(x, y))

func get_cells_in(start_x: int, start_y: int, end_x: int, end_y: int) -> Array:
	var cell_data: Array[Dictionary] = []
	for x in range(start_x, end_x):
		for y in range(start_y, end_y):
			var c: Dictionary = get_cell(x, y)
			if not c.is_empty(): cell_data.push_back(c)

	return cell_data

func query_against(layer: GridLayer, x: int, y: int) -> Array:
	if cell_size <= layer.cell_size:
		var target_x: int = floori(float(x) * cell_size / layer.cell_size)
		var target_y: int = floori(float(y) * cell_size / layer.cell_size)
		var found = layer.get_cell(target_x, target_y)
		return [found]

	else:
		@warning_ignore("integer_division") # Grids are always powers of 2, so they are automatically resolved to whole numbers
		var ratio: int = cell_size / layer.cell_size
		var start_x: int = x * ratio
		var start_y: int = y * ratio
		return layer.get_cells_in(start_x, start_y, start_x + ratio, start_y + ratio)
