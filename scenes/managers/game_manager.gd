extends Node
class_name GameManager

var current_player: Enums.Player = Enums.Player.X
var rows: Array
var cols: Array
var main_diag: int
var anti_diag: int
var moves: int

signal game_over(winner: Enums.Player)
signal game_draw()

func _ready() -> void:
	initialize()
	print("game_manager initialized.")

func determine_winner(row:int, col:int) -> void:
	var value = current_player as int
	rows[row] += value
	cols[col] += value
	
	if row == col:
		main_diag += value
	if (row + col) == 2:
		anti_diag += value
	
	moves += 1
		
	if abs(rows[row]) == 3 or abs(cols[col]) == 3 or abs(main_diag) == 3 or abs(anti_diag) == 3:
		game_over.emit(current_player)
	elif moves == 9:
		game_draw.emit()
	#else:
	current_player = (Enums.Player.X if current_player == Enums.Player.O else Enums.Player.O)


func initialize() -> void:
	rows = [0,0,0]
	cols = [0,0,0]
	main_diag = 0
	anti_diag = 0
	moves = 0
	#current_player = (current_player if current_player != null else Enums.Player.X)

func get_result_index() -> String:
	for index in range(rows.size()):
		if abs(rows[index]) == 3:
			return "%s:0|%s:2" % [index, index]
	
	for index in range(cols.size()):
		if abs(cols[index]) == 3:
			return "0:%s|2:%s" % [index, index]
	
	if abs(main_diag) == 3:
		return "0:0|2:2"
	elif abs(anti_diag) == 3:
		return "0:2|2:0"
	else:
		return ""
