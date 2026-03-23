extends Node

@export var end_screen_scene: PackedScene

@onready var game_manager: GameManager = $GameManager
@onready var game_ui: GameUi = $GameUi

var options_menu_scene = preload("res://scenes/ui/options_menu/options_menu.tscn")


func _ready() -> void:
	GameEvents.open_options_menu.connect(_on_game_events_open_options_menu)
	GameEvents.game_over.connect(_on_game_events_game_over)
	GameEvents.game_draw.connect(_on_game_events_game_draw)


func create_end_screen_instance() -> EndScreen:
	var end_screen_instance: EndScreen = end_screen_scene.instantiate()
	end_screen_instance.restart_game.connect(_on_end_screen_restart)
	game_ui.add_child_to_panel_container(end_screen_instance)
	return end_screen_instance


func disable_all_input(disable: bool) -> void:
	get_viewport().gui_disable_input = disable


func _on_game_events_game_over(winner: Enums.Player) -> void:
	GameData.add_score(winner)
	disable_all_input(true)
	await game_ui.display_cross_line()
	game_ui.blur()
	await create_end_screen_instance().show_winner(winner, game_manager.get_result_pivot_location())
	disable_all_input(false)


func _on_game_events_game_draw() -> void:
	disable_all_input(true)
	game_ui.blur()
	await  create_end_screen_instance().show_draw()
	disable_all_input(false)


func _on_end_screen_restart() -> void:
	game_manager.initialize()
	game_ui.restart()
	if (GameData.mode == Enums.Mode.AI):
		game_ui.ai_make_move()


func _on_game_events_open_options_menu() -> void:
	game_ui.blur()
	var options_menu: OptionsMenu = options_menu_scene.instantiate()
	options_menu.close.connect(game_ui.unblur)
	add_child(options_menu)
	
