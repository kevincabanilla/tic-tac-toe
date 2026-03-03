extends CanvasLayer
class_name GameMenu

@onready var game_over_msg = %GameOverMessage

signal start_game()

func show_winner(winner: Enums.Player) -> void:
	game_over_msg.msg_label.text = "WINNER!"
	game_over_msg.x_label.visible = winner == Enums.Player.X
	game_over_msg.o_label.visible = winner == Enums.Player.O
	

func show_draw() -> void:
	game_over_msg.msg_label.text = "DRAW!"
	game_over_msg.x_label.visible = true
	game_over_msg.o_label.visible = true


func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		start_game.emit()
		queue_free()
