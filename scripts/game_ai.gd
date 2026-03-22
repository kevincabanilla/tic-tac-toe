extends Node

var difficulty := Enums.Difficulty.Easy

func make_move(board: Array) -> Dictionary:
	return _easy_move(board)


func _easy_move(board: Array) -> Dictionary:
	var empty_cells: Array[Dictionary] = []
	print(board)
	for row in range(board.size()):
		for col in range(board[row].size()):
			if board[row][col] == 0:
				empty_cells.append({"row": row, "col": col})

	print(empty_cells)
	if empty_cells.size() > 0:
		var choice: Dictionary = empty_cells[randi() % empty_cells.size()]
		return choice
	else:
		return {}
