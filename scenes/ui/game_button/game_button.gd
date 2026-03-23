extends Button
class_name GameButton

@onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	text = ""

func reset() -> void:
	disabled = false
	await play_animation(true)
	text = ""


func play_animation(backwards := false):
	if backwards:
		_animation_player.play_backwards("scale_animation")
	else:
		_animation_player.play("scale_animation")
	await _animation_player.animation_finished
