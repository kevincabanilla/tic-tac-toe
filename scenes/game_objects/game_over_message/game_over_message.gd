extends VBoxContainer
class_name GameOverMessage

@onready var msg_label = %Label
@onready var x_label = %XLabel
@onready var o_label = %OLabel
	
#func _init() -> void:
	#scale = Vector2.ZERO

func _ready() -> void:
	modulate = Color.TRANSPARENT
	set_pivot_location(Enums.PivotLocation.Center)
	#play_draw_animation()


func play_win_animation(winner: Enums.Player) -> void:
	#await get_tree().create_timer(3.0).timeout
	msg_label.text = "WINNER!"
	x_label.visible = winner == Enums.Player.X
	o_label.visible = winner == Enums.Player.O
	await get_tree().process_frame
	await play_animation().finished

func play_draw_animation() -> void:
	msg_label.text = "DRAW!"
	x_label.visible = true
	o_label.visible = true
	await get_tree().process_frame
	await play_animation().finished

func play_animation() -> Tween:
	#$AnimationPlayer.play("scale_animation")
	#$AnimationPlayer.seek(0, true) # The 'true' argument ensures the visuals update immediately	
	
	modulate.a = 1.0
	var tween = create_tween()
	tween.tween_method(update_scale, Vector2.ZERO, Vector2.ONE, 1.25)\
	.set_trans(Tween.TRANS_BACK)\
	.set_ease(Tween.EASE_OUT)
	return tween

func update_scale(value: Vector2):
	scale = value


func set_pivot_location(pivot_loc: Enums.PivotLocation) -> void:
	match pivot_loc:
		Enums.PivotLocation.Top:
			pivot_offset = Vector2(size.x / 2, 0)
		Enums.PivotLocation.Right:
			pivot_offset = Vector2(size.x, size.y / 2)
		Enums.PivotLocation.Bottom:
			pivot_offset = Vector2(size.x / 2, size.y)
		Enums.PivotLocation.Left:
			pivot_offset = Vector2(0, size.y / 2)
		Enums.PivotLocation.Center:
			pivot_offset = size / 2         # Scale from center (important for UI)


#func _on_player_x_pressed() -> void:
	#start_game.emit(Enums.Player.X)
#
#
#func _on_player_o_pressed() -> void:
	#start_game.emit(Enums.Player.O)
