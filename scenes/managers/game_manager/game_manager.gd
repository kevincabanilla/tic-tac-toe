extends Node
class_name GameManager

var current_player: Enums.Player = Enums.Player.X
var rows: Array
var cols: Array
var main_diag: int
var anti_diag: int
var moves: int


func _ready() -> void:
	initialize()
	print("game_manager initialized.")

func get_next_player(row:int, col:int) -> Enums.Player:
	var value = current_player as int
	rows[row] += value
	cols[col] += value
	
	if row == col:
		main_diag += value
	if (row + col) == 2:
		anti_diag += value
	
	moves += 1
		
	if abs(rows[row]) == 3 or abs(cols[col]) == 3 or abs(main_diag) == 3 or abs(anti_diag) == 3:
		GameEvents.game_over.emit(current_player)
	elif moves == 9:
		GameEvents.game_draw.emit()
	#else:
	current_player = (Enums.Player.X if current_player == Enums.Player.O else Enums.Player.O)
	return current_player


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


func get_result_pivot_location() -> Enums.PivotLocation:
	if (abs(rows[0]) == 3):
		return Enums.PivotLocation.Top
	elif (abs(rows[2]) == 3):
		return Enums.PivotLocation.Bottom
	elif (abs(cols[0]) == 3):
		return Enums.PivotLocation.Left
	elif (abs(cols[2]) == 3):
		return Enums.PivotLocation.Right
	else:
		return Enums.PivotLocation.Center
