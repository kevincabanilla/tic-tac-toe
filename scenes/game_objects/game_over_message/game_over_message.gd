extends VBoxContainer
class_name GameOverMessage

@onready var msg_label = %Label
@onready var x_label = %XLabel
@onready var o_label = %OLabel

func _init() -> void:
	visible = false
	pivot_offset = size / 2         # Scale from center (important for UI)
	scale = Vector2.ZERO

func _ready() -> void:
	msg_label.visible = false
	x_label.visible = false
	o_label.visible = false


func play_win_animation(winner: Enums.Player) -> void:
	#await get_tree().create_timer(3.0).timeout
	var tween = play_animation()
	msg_label.text = "WINNER!"
	msg_label.visible = true
	x_label.visible = winner == Enums.Player.X
	o_label.visible = winner == Enums.Player.O
	await tween.finished

func play_draw_animation() -> void:
	var tween = play_animation()
	msg_label.text = "DRAW!"
	msg_label.visible = true
	x_label.visible = true
	o_label.visible = true
	await tween.finished

func play_animation() -> Tween:
	#$AnimationPlayer.play("scale_animation")
	#$AnimationPlayer.seek(0, true) # The 'true' argument ensures the visuals update immediately	
	visible = true
	#pivot_offset = size / 2         # Scale from center (important for UI)
	scale = Vector2.ZERO
	
	var tween = create_tween()
	tween.tween_method(update_scale, Vector2.ZERO, Vector2.ONE, 0.8)\
	.set_trans(Tween.TRANS_BACK)\
	.set_ease(Tween.EASE_OUT)
	return tween

func update_scale(value: Vector2):
	scale = value

#func _on_player_x_pressed() -> void:
	#start_game.emit(Enums.Player.X)
#
#
#func _on_player_o_pressed() -> void:
	#start_game.emit(Enums.Player.O)
