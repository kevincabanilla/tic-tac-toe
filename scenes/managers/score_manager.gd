extends Node
class_name ScoreManager

var _player_x_score = 0
var _player_o_score: = 0

func add_score(player: Enums.Player) -> void:
	match player:
		Enums.Player.X:
			_player_x_score += 1
		_: # wildcard pattern (default)
			_player_o_score += 1

func get_player_x_score() -> int:
	return _player_x_score
	
func get_player_o_score() -> int:
	return _player_o_score
