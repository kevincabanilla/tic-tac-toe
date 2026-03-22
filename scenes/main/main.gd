extends Node

@export var game_menu_scene: PackedScene

@onready var game_manager: GameManager = $GameManager
@onready var game_ui: GameUi = $GameUi

func create_game_menu_instance() -> EndScreen:
	var game_menu_instance = game_menu_scene.instantiate() as  EndScreen
	game_menu_instance.start_game.connect(_on_game_menu_start_game)
	add_child(game_menu_instance)
	return game_menu_instance

func _ready() -> void:
	GameEvents.game_over.connect(_on_game_events_game_over)
	GameEvents.game_draw.connect(_on_game_events_game_draw)



func disable_all_input(disable: bool) -> void:
	get_viewport().gui_disable_input = disable

func _on_game_events_game_over(winner: Enums.Player) -> void:
	GameData.add_score(winner)
	disable_all_input(true)
	await game_ui.display_cross_line()
	game_ui.blur()
	await create_game_menu_instance().show_winner(winner, game_manager.get_result_pivot_location())
	disable_all_input(false)


func _on_game_events_game_draw() -> void:
	disable_all_input(true)
	game_ui.blur()
	await  create_game_menu_instance().show_draw()
	disable_all_input(false)


func _on_game_menu_start_game() -> void:
	game_manager.initialize()
	game_ui.restart()
