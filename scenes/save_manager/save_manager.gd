extends Node

# TODO: Save File versioning and migration logic

var log = Log.new(["SaveManager"])

const SAVE_FILE_RESOURCES_NAME: String = "save_file_resources.dat"

@export var save_file_resources: Array[SaveFileResource] = []

var subdir: String:
	get: return Application.get_subdirectory_path(Application.Subdir.SAVE)


func _get_save_file_resources_path() -> String:
	return subdir.path_join(SAVE_FILE_RESOURCES_NAME)


func _get_game_data_path(save_id: String) -> String:
	return subdir.path_join(save_id + ".dat")


func _write_resource(path: String, res: Resource) -> bool:
	var tmp_dir = DirAccess.create_temp(Application.app_name)
	if tmp_dir == null:
		log.error("error creating temp dir: %s" % DirAccess.get_open_error())
		return false
	var tmp_path = tmp_dir.get_current_dir().path_join(path.get_file())
	var file = FileAccess.open(tmp_path, FileAccess.WRITE)
	if file == null:
		log.error("error opening temp file %s: %s" % [tmp_path, FileAccess.get_open_error()])
		return false
	file.store_var(res, true)
	file.close()
	if DirAccess.copy_absolute(tmp_path, path) != OK:
		log.error("error copying %s to %s" % [tmp_path, path])
		return false
	return true


func _write_save_file_resources() -> bool:
	log.info("writing save_file_resources to disk")
	var tmp_dir = DirAccess.create_temp(Application.app_name)
	if tmp_dir == null:
		log.error("error creating temp dir: %s" % DirAccess.get_open_error())
		return false
	var tmp_path = tmp_dir.get_current_dir().path_join(SAVE_FILE_RESOURCES_NAME)
	var file = FileAccess.open(tmp_path, FileAccess.WRITE)
	if file == null:
		log.error("error opening temp file: %s" % FileAccess.get_open_error())
		return false
	for sfr in save_file_resources:
		file.store_var(sfr, true)
	file.close()
	if DirAccess.copy_absolute(tmp_path, _get_save_file_resources_path()) != OK:
		log.error("error copying to %s" % _get_save_file_resources_path())
		return false
	return true


func create_new_save(save_name: String) -> SaveFileResource:
	log.info("creating new save: %s" % save_name)
	var save_file = SaveFileResource.create(save_name)
	save_file_resources.push_back(save_file)
	_write_save_file_resources()
	var game_data = SaveGameData.capture()
	_write_resource(_get_game_data_path(save_file.id), game_data)
	log.info("save created: %s" % save_file.id)
	return save_file


func load_save_file_resources() -> Array[SaveFileResource]:
	var sfr: Array[SaveFileResource] = []
	var path = _get_save_file_resources_path()
	log.info("loading save_file_resources from %s" % path)
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		var open_error: int = FileAccess.get_open_error()
		match open_error:
			ERR_FILE_NOT_FOUND:
				log.info("no save file found at %s" % path)
				return []
			_:
				log.error("error opening %s: %s" % [path, open_error])
				return []

	while file.get_position() < file.get_length():
		sfr.push_back(file.get_var(true))
	return sfr


func load_game_data(save_id: String) -> SaveGameData:
	var path = _get_game_data_path(save_id)
	log.info("loading game data from %s" % path)
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		log.error("error opening %s: %s" % [path, FileAccess.get_open_error()])
		return null
	return file.get_var(true)


func update_save(save_id: String) -> bool:
	log.info("updating save: %s" % save_id)
	var idx = save_file_resources.find_custom(func(sfr): return sfr.id == save_id)
	if idx == -1:
		log.error("save not found: %s" % save_id)
		return false
	save_file_resources[idx].date = Time.get_datetime_dict_from_system()
	_write_save_file_resources()
	var game_data = SaveGameData.capture()
	return _write_resource(_get_game_data_path(save_id), game_data)


func delete_save(save_id: String) -> bool:
	log.info("deleting save: %s" % save_id)
	var idx = save_file_resources.find_custom(func(sfr): return sfr.id == save_id)
	if idx == -1:
		log.error("save not found: %s" % save_id)
		return false
	save_file_resources.remove_at(idx)
	_write_save_file_resources()
	var path = _get_game_data_path(save_id)
	if DirAccess.remove_absolute(path) != OK:
		log.error("error deleting %s" % path)
		return false
	return true


func _ready() -> void:
	save_file_resources = load_save_file_resources()
