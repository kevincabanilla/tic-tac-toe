extends Node

const SAVE_FILE_PATH = "user://game.save"

var mode := Enums.Mode.AI
var difficulty := Enums.Difficulty.Medium
var allow_draw := true

var player_x_score := 0
var player_o_score := 0

signal player_score_updated(player: Enums.Player, new_score: int)

func _ready() -> void:
	load_data()


func load_data() -> void:
	
	if (!FileAccess.file_exists(SAVE_FILE_PATH)):
		return
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	var save_data := file.get_var() as Dictionary
	mode = save_data["mode"]
	difficulty = save_data["difficulty"]
	allow_draw = save_data["allow_draw"]


func save_data() -> void:
	var save_data := {
		"mode": mode,
		"difficulty": difficulty,
		"allow_draw": allow_draw
	}
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)


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
