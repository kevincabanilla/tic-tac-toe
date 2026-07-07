extends Node

const SAVE_FILE_PATH = "user://game.save"

var _game_data := {
	"mode": Enums.Mode.AI,
	"difficulty": Enums.Difficulty.Impossible,
	"allow_draw": true
}
var _loaded_data := {} # Readonly for saving purposes, do not modify.

var mode: Enums.Mode:
	set(value):
		_game_data["mode"] = value
	get:
		return _game_data["mode"]

var difficulty: Enums.Difficulty:
	set(value):
		_game_data["difficulty"] = value
	get:
		return _game_data["difficulty"]

var allow_draw: bool:
	set(value):
		_game_data["allow_draw"] = value
	get:
		return _game_data["allow_draw"]

var has_unsaved_changes: bool:
	get:
		return _game_data.hash() != _loaded_data.hash()

var player_x_score := 0
var player_o_score := 0

signal player_score_updated(player: Enums.Player, new_score: int)

func _ready() -> void:
	load_data()


func load_data() -> void:	
	if (!FileAccess.file_exists(SAVE_FILE_PATH)):
		return
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	_game_data = file.get_var()
	_loaded_data = _game_data.duplicate(true)
	update_copy()

func save_data() -> void:
	if !has_unsaved_changes:
		return
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(_game_data)
	update_copy()


func update_copy() -> void:
	_loaded_data = _game_data.duplicate(true)


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
