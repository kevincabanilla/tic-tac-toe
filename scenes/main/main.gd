extends Node

@export var game_menu_scene: PackedScene

@onready var game_manager = $GameManager
@onready var score_manager = $ScoreManager
@onready var game_ui = $GameUi

func create_game_menu_instance() -> GameMenu:
	var game_menu_instance = game_menu_scene.instantiate() as  GameMenu
	game_menu_instance.start_game.connect(_on_game_menu_start_game)
	add_child(game_menu_instance)
	return game_menu_instance

func disable_all_input(disable: bool) -> void:
	get_viewport().gui_disable_input = disable

func _on_game_manager_game_over(winner: Enums.Player) -> void:
	score_manager.add_score(winner)
	game_ui.update_score(score_manager.get_player_x_score(), score_manager.get_player_o_score())
	disable_all_input(true)
	await game_ui.display_cross_line()
	await create_game_menu_instance().show_winner(winner)
	disable_all_input(false)


func _on_game_manager_game_draw() -> void:
	disable_all_input(true)
	await  create_game_menu_instance().show_draw()
	disable_all_input(false)


func _on_game_menu_start_game() -> void:
	game_manager.initialize()
	game_ui.initialize()
