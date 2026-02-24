class_name Attribute extends Resource

# NOTE: If we need type safe access, we can probably just delegate to child classes
signal value_changed(old_value: int, new_value: int)

@export var id: String

@export var value: int = 0:
	set(new_value):
		if new_value != null and new_value != value:
			var old = value
			value = new_value
			value_changed.emit(old, new_value)

static func create(_id: String, _value: int) -> Attribute:
	var attribute = Attribute.new()
	attribute.id = _id
	attribute.value = _value
	return attribute
