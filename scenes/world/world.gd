class_name World extends Node2D

var log = Log.new(["World"])

signal world_initialized()

@export var grid: WorldGrid = WorldGrid.new()

func initialize() -> void:
	world_initialized.emit()
	return

var small_grid = GridLayer.create(8)
var big_grid = GridLayer.create(64)
