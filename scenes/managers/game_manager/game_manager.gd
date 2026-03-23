extends Node
class_name GameManager

var current_player: Enums.Player = Enums.Player.X
var board: Array
var rows: Array
var cols: Array
var main_diag: int
var anti_diag: int
var moves: int
var is_game_over: bool
var cell_queue: Array[int]

signal reset_cell(index: int)

func _ready() -> void:
	initialize()


func initialize() -> void:
	board = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
	]
	rows = [0,0,0]
	cols = [0,0,0]
	main_diag = 0
	anti_diag = 0
	moves = 0
	cell_queue = []
	is_game_over = false
	#current_player = (current_player if current_player != null else Enums.Player.X)
	print("game_manager initialized.")


func make_move(row:int, col:int) -> Enums.Player:
	var value = current_player as int
	board[row][col] = value
	rows[row] += value
	cols[col] += value
	
	if row == col:
		main_diag += value
	if (row + col) == 2:
		anti_diag += value
	
	if !GameData.allow_draw:
		update_queue(row, col, current_player)
	else:
		moves += 1
	
	if abs(rows[row]) == 3 or abs(cols[col]) == 3 or abs(main_diag) == 3 or abs(anti_diag) == 3:
		is_game_over = true
		GameEvents.game_over.emit(current_player)
	elif moves == 9:
		is_game_over = true
		GameEvents.game_draw.emit()
	
	current_player = (Enums.Player.X if current_player == Enums.Player.O else Enums.Player.O)
	return current_player


func update_queue(row:int, col:int, player: Enums.Player) -> void:
	if (GameData.allow_draw):
		return
		
	cell_queue.push_back((row * 3) + col)
	if (cell_queue.size() >= 7):
		var reset_cell_index: int = cell_queue.pop_front()		
		var reset_row := reset_cell_index / 3
		var reset_col := reset_cell_index % 3
		board[reset_row][reset_col] = 0
		
		var value: = player * -1 # Negate value
		rows[reset_row] += value
		cols[reset_col] += value
		if reset_row == reset_col:
			main_diag += value
		if (reset_row + reset_col) == 2:
			anti_diag += value
		
		#print("rows: " + str(rows))
		#print("cols: " + str(cols))
		#print("main_diag: " + str(main_diag))
		#print("anti_diag: " + str(anti_diag))
		reset_cell.emit(reset_cell_index)


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
