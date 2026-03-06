extends CanvasLayer
class_name GameMenu

@onready var game_over_msg = %GameOverMessage

signal start_game()

func show_winner(winner: Enums.Player) -> void:
	await game_over_msg.play_win_animation(winner)	
	

func show_draw() -> void:
	await game_over_msg.play_draw_animation()


func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		start_game.emit()
		queue_free()
