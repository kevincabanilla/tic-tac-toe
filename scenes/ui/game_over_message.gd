extends VBoxContainer
class_name GameOverMessage

@onready var msg_label = %Label
@onready var x_label = %XLabel
@onready var o_label = %OLabel


#func show_animation() -> void:
	#alert_container.scale = Vector2.ZERO				            # Start invisible (0 scale)
	#alert_container.pivot_offset = alert_container.size / 2         # Scale from center (important for UI)
	#visible = true
#
	#var tween = create_tween()
	#tween.tween_property(alert_container, "scale", Vector2.ONE, 0.4)\
	#.set_trans(Tween.TRANS_BACK)\
	#.set_ease(Tween.EASE_OUT)
	

#func _on_player_x_pressed() -> void:
	#start_game.emit(Enums.Player.X)
#
#
#func _on_player_o_pressed() -> void:
	#start_game.emit(Enums.Player.O)
