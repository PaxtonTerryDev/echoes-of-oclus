extends Node

@export var loading_screen: PackedScene
@export var world_scene: PackedScene
@export var main_menu_scene: PackedScene

@export var transition_duration: float = 0.6
@export var min_load_time: float = 1.0

@export var _overlay: ColorRect
@export var _loading_layer: CanvasLayer
var _shader: ShaderMaterial
var _loading_screen_instance: Node

var _transitioning: bool = false


func _ready() -> void:
	_shader = _overlay.material as ShaderMaterial


func _swap_scene(packed: PackedScene) -> void:
	if _transitioning:
		return
	_transitioning = true

	await _animate_progress(0.0, 1.0)
	get_tree().change_scene_to_packed(packed)
	_show_loading_screen()
	await get_tree().create_timer(min_load_time).timeout
	_hide_loading_screen()
	await _animate_progress(1.0, 0.0)

	_transitioning = false


func _show_loading_screen() -> void:
	if loading_screen == null:
		return
	_loading_screen_instance = loading_screen.instantiate()
	_loading_layer.add_child(_loading_screen_instance)


func _hide_loading_screen() -> void:
	if _loading_screen_instance == null:
		return
	_loading_screen_instance.queue_free()
	_loading_screen_instance = null


func _animate_progress(from: float, to: float) -> void:
	var tween = create_tween()
	tween.tween_method(
		func(v: float): _shader.set_shader_parameter("progress", v),
		from, to, transition_duration
	)
	await tween.finished


func to_world(save_id: String = "") -> void:
	if save_id.is_empty():
		WorldState.reset()
	else:
		var game_data = SaveManager.load_game_data(save_id)
		WorldState.load_from(game_data.world_state)
	_swap_scene(world_scene)


func to_main_menu() -> void:
	_swap_scene(main_menu_scene)
