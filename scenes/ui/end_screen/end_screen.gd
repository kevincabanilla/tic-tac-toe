class_name EndScreen extends MarginContainer


@onready var game_over_msg: GameOverMessage = %GameOverMessage

signal start_game()

func show_winner(winner: Enums.Player, pivot_loc: Enums.PivotLocation) -> void:
	await game_over_msg.play_win_animation(winner, pivot_loc)
	

func show_draw() -> void:
	await game_over_msg.play_draw_animation()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		await game_over_msg.close()
		start_game.emit()
		queue_free()
