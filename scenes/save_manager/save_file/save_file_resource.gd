class_name SaveFileResource extends Resource

@export var id: String
@export var name: String
@export var app_version: String
@export var date: Dictionary

static func create(save_name: String = "") -> SaveFileResource:
	var save_file = SaveFileResource.new()
	save_file.id = UUID.generate()
	save_file.name = save_name
	save_file.app_version = Application.APP_VERSION
	save_file.date = Time.get_datetime_dict_from_system()
	return save_file
