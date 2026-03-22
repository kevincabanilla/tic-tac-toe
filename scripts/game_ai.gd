extends Node

var difficulty := Enums.Difficulty.Easy

func make_move(board: Array) -> Dictionary:
	return _medium_move(board)


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


func _medium_move(board: Array) -> Dictionary:
	# Rules:
	# 1. Win if possible
	# 2. Block player from winning
	# 3. Pick center
	# 4. Pick random
	var new_board: Array[Enums.Player] = []
	
	for row in range(board.size()):
		for col in range(board[row].size()):
			new_board.append(board[row][col])
			
	var move := find_winning_move(new_board, Enums.Player.O)
	
	if move != -1:
		return { "row": move / 3, "col": move % 3 }

	move = find_winning_move(new_board, Enums.Player.X)
	if move != -1:
		return { "row": move / 3, "col": move % 3 }

	if new_board[4] == 0 && randf() > .6:
		return { "row": 1, "col": 1 }

	return _easy_move(board)


func _hard_move(board: Array) -> Dictionary:
	return {}


func find_winning_move(board: Array, player: Enums.Player) -> int:
	var win_combinations = [
		[0,1,2], # top row
		[3,4,5], # middle row
		[6,7,8], # bottom row
		[0,3,6], # left column
		[1,4,7], # middle column
		[2,5,8], # right column
		[0,4,8], # diagonal
		[2,4,6]  # diagonal
	]
	for combo in win_combinations:
		var a = combo[0]
		var b = combo[1]
		var c = combo[2]

		var values := [board[a], board[b], board[c]] # Ex. value: []

		if values.count(player) == 2 and values.count(0) == 1:
			if board[a] == 0:
				return a
			elif board[b] == 0:
				return b
			else:
				return c
	return -1
