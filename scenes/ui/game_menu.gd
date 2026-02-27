extends CanvasLayer
class_name GameMenu

signal start_game()

func set_message(text: String) -> void:
	%Label.text = text


func _on_player_x_pressed() -> void:
	start_game.emit(Enums.Player.X)


func _on_player_o_pressed() -> void:
	start_game.emit(Enums.Player.O)
