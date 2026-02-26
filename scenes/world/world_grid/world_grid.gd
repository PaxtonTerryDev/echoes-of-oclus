class_name WorldGrid extends Resource

var log = Log.new(["WorldGrid"])

var layers: Dictionary = {
	map = GridLayer.create(8),
	movement = GridLayer.create(16)
}
