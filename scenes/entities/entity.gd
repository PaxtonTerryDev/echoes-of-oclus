class_name Entity extends Node2D

@export var attributes: EntityAttributes

func _ready() -> void:
	attributes = EntityAttributes.create({ "strength": 10 })
