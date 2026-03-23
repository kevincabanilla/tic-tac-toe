extends BoxContainer
class_name GameOverMessage

@onready var main_container: VBoxContainer = $MainContainer
@onready var msg_label = %Label
@onready var x_label = %XLabel
@onready var o_label = %OLabel
	
#func _init() -> void:
	#scale = Vector2.ZERO

func _ready() -> void:
	modulate = Color.TRANSPARENT
	#play_draw_animation()


func play_win_animation(winner: Enums.Player, pivot_loc: Enums.PivotLocation) -> void:
	#await get_tree().create_timer(3.0).timeout
	x_label.visible = winner == Enums.Player.X
	o_label.visible = winner == Enums.Player.O
	msg_label.text = "WINNER!"
	await set_pivot_location(pivot_loc)
	await play_animation().finished

func play_draw_animation() -> void:
	msg_label.text = "DRAW!"
	x_label.visible = true
	o_label.visible = true
	await set_pivot_location(Enums.PivotLocation.Center)
	await play_animation().finished


func close() -> void:
	var tween = create_tween()
	tween.tween_property(main_container, "scale", Vector2.ZERO, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(queue_free)
	await tween.finished


func play_animation() -> Tween:
	#$AnimationPlayer.play("scale_animation")
	#$AnimationPlayer.seek(0, true) # The 'true' argument ensures the visuals update immediately	
	
	modulate.a = 1.0
	var tween = create_tween()
	tween.tween_method(update_scale, Vector2.ZERO, Vector2.ONE, 1)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	return tween


func update_scale(value: Vector2):
	main_container.scale = value


func set_pivot_location(pivot_loc: Enums.PivotLocation) -> void:
	await get_tree().process_frame
	match pivot_loc:
		Enums.PivotLocation.Top:
			main_container.pivot_offset = Vector2(size.x / 2, 0)
		Enums.PivotLocation.Right:
			main_container.pivot_offset = Vector2(size.x, size.y / 2)
		Enums.PivotLocation.Bottom:
			main_container.pivot_offset = Vector2(size.x / 2, size.y)
		Enums.PivotLocation.Left:
			main_container.pivot_offset = Vector2(0, size.y / 2)
		_:
			main_container.pivot_offset = size / 2         # Scale from center (important for UI)


#func _on_player_x_pressed() -> void:
	#start_game.emit(Enums.Player.X)
#
#
#func _on_player_o_pressed() -> void:
	#start_game.emit(Enums.Player.O)
