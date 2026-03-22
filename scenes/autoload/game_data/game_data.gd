extends Node

var player_x_score := 0
var player_o_score := 0

signal player_score_updated(player: Enums.Player, new_score: int)

func add_score(player: Enums.Player) -> void:
	var new_score := 0
	match player:
		Enums.Player.X:
			player_x_score += 1
			new_score = player_x_score
		_: # wildcard pattern (default)
			player_o_score += 1
			new_score = player_o_score
	player_score_updated.emit(player, new_score)
