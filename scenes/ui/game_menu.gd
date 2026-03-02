extends CanvasLayer
class_name GameMenu

signal start_game()

func set_message(text: String) -> void:
	%Label.text = text

func show_winner(winner: Enums.Player) -> void:
	set_message("WINNER!")
	%XLabel.visible = winner == Enums.Player.X
	%OLabel.visible = winner == Enums.Player.O
	

func show_draw() -> void:
	set_message("DRAW!")
	%XLabel.visible = true
	%OLabel.visible = true

#func _on_player_x_pressed() -> void:
	#start_game.emit(Enums.Player.X)
#
#
#func _on_player_o_pressed() -> void:
	#start_game.emit(Enums.Player.O)


func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		start_game.emit()
