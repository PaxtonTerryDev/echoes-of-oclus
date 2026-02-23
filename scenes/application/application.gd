extends Node

var log = Log.new(["Application"])

@onready var env: Env = get_env()

const APP_VERSION: String = "0.0.1"

var app_name: String:
	get: return "_".join(ProjectSettings.get_setting("application/config/name").to_lower().split(" "))

func get_env() -> Env:
	return Env.DEV if is_dev() else Env.PROD

func is_dev() -> bool:
	return OS.has_feature("editor")

enum Env {
	DEV,
	PROD
}

enum Subdir {
	SAVE,
	MODS
}

const Subdirectories: Dictionary[Subdir, String] = {
	Subdir.SAVE: "save_data",
	Subdir.MODS: "mods"
}

const RootDir: Dictionary[Env, String] = {
	Env.DEV: "res://tmp",
	Env.PROD: "user://"
}

func get_root_data_dir() -> String:
	return RootDir[env]

func get_subdirectory_path(subdir: Subdir) -> String:
	return get_root_data_dir().path_join(Subdirectories[subdir])

func _ensure_directories() -> void:
	log.info("ensuring subdirectories exist...")
	for subdir in Subdirectories:
		DirAccess.make_dir_recursive_absolute(get_subdirectory_path(subdir))
	log.info("subdirectories verified")

func _ready() -> void:
	log.info(app_name)
	_ensure_directories()
