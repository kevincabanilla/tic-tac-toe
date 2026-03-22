extends Button
class_name GameButton

@onready var _animation_player: AnimationPlayer = $AnimationPlayer

func play_animation():
	_animation_player.play("x_animation")
