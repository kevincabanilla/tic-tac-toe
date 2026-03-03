extends Node

@onready var game_manager = $GameManager
@onready var score_manager = $ScoreManager
@onready var game_ui = $GameUi
@onready var game_menu = $GameMenu


func _on_game_manager_game_over(winner: Enums.Player) -> void:
	score_manager.add_score(winner)
	game_ui.update_score(score_manager.get_player_x_score(), score_manager.get_player_o_score())
	#game_menu.set_message("Player %s wins!" % ("X" if winner == Enums.Player.X else "O"))
	game_menu.show_winner(winner)


func _on_game_manager_game_draw() -> void:
	game_menu.show_draw()


func _on_game_menu_start_game() -> void:
	game_manager.initialize()
	game_ui.initialize()
