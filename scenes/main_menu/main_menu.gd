extends Control

@export_category("Refs")
@export_group("Buttons")
@export var _button_container: Container
@export var _new_game_btn: Button
@export var _load_game_btn: Button
@export var _settings_btn: Button

@export_group("Load Game")
@export var _load_game_panel: Container
@export var _saved_games_search: TextEdit
@export var _saved_games_container: VBoxContainer


func _ready() -> void:
	_new_game_btn.pressed.connect(func(): SceneLoader.to_world())
