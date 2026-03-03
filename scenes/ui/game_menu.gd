extends CanvasLayer
class_name GameMenu

@export var game_over_message_scene: PackedScene

@onready var center_container = %CenterContainer

signal start_game()


func show_winner(winner: Enums.Player) -> void:
	visible = true
	var game_over_instance = game_over_message_scene.instantiate() as GameOverMessage
	center_container.add_child(game_over_instance)
	game_over_instance.msg_label.text = "WINNER!"
	game_over_instance.x_label.visible = winner == Enums.Player.X
	game_over_instance.o_label.visible = winner == Enums.Player.O
	

func show_draw() -> void:
	visible = true
	var game_over_instance = game_over_message_scene.instantiate() as GameOverMessage
	center_container.add_child(game_over_instance)
	game_over_instance.msg_label.text = "DRAW!"
	game_over_instance.x_label.visible = true
	game_over_instance.o_label.visible = true


func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		visible = false
		center_container.get_child(0).queue_free()
		start_game.emit()
