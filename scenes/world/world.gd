class_name World extends Node2D

signal world_initialized()

func initialize() -> void:
	world_initialized.emit()
	return
