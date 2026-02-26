class_name World extends Node2D

var log = Log.new(["World"])

signal world_initialized()

func initialize() -> void:
	world_initialized.emit()
	return
