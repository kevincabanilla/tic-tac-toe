extends Node

var win_combinations := [
		[0,1,2], # top row
		[3,4,5], # middle row
		[6,7,8], # bottom row
		[0,3,6], # left column
		[1,4,7], # middle column
		[2,5,8], # right column
		[0,4,8], # diagonal
		[2,4,6]  # diagonal
	]

func make_move(board: Array) -> Dictionary:
	match GameData.difficulty:
		Enums.Difficulty.Easy:
			return _easy_move(board)
		Enums.Difficulty.Medium:
			return _medium_move(board)
		Enums.Difficulty.Hard:
			return _medium_move(board, true)
		_:
			return _impossible_move(board)


func _easy_move(board: Array) -> Dictionary:
	var empty_cells: Array[Dictionary] = []
	
	for row in range(board.size()):
		for col in range(board[row].size()):
			if board[row][col] == 0:
				empty_cells.append({"row": row, "col": col})

	if empty_cells.size() > 0:
		var choice: Dictionary = empty_cells[randi() % empty_cells.size()]
		return choice
	else:
		return {}


func _medium_move(board: Array, pick_center := false) -> Dictionary:
	# Rules:
	# 1. Win if possible
	# 2. Block player from winning
	# 3. Pick center
	# 4. Pick random
	var new_board: Array[Enums.Player] = _convert_board_into_singel_array(board)
			
	var move := _find_winning_move(new_board, Enums.Player.O)
	
	if move != -1:
		return { "row": move / 3, "col": move % 3 }

	move = _find_winning_move(new_board, Enums.Player.X)
	if move != -1:
		return { "row": move / 3, "col": move % 3 }

	if pick_center && new_board[4] == 0 && randf() > .2:
		return { "row": 1, "col": 1 }


	return _easy_move(board)


func _impossible_move(base_board: Array) -> Dictionary:
	var best_score = -INF
	var move = -1
	var board := _convert_board_into_singel_array(base_board)
	
	if board.all(func(cell: int): return cell == 0):
		return { "row": 1, "col": 1 }

	for i in range(9):
		if board[i] == 0:
			board[i] = Enums.Player.O
			var score = _minimax(board, false)
			board[i] = 0

			if score > best_score:
				best_score = score
				move = i

	#var move = best_moves.pick_random()
	return { "row": move / 3, "col": move % 3 }


func _convert_board_into_singel_array(board: Array) -> Array:
	var new_board: Array[Enums.Player] = []	
	for row in range(board.size()):
		for col in range(board[row].size()):
			new_board.append(board[row][col])
	return new_board


func _find_winning_move(board: Array, player: Enums.Player) -> int:
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


func _minimax(board: Array, is_maximizing: bool):
	var result = _get_winner_score(board)
	if result != null:
		return result

	if is_maximizing:
		var best_score = -INF
		for i in range(9):
			if board[i] == 0:
				board[i] = Enums.Player.O
				var score = _minimax(board, false)
				board[i] = 0
				best_score = max(score, best_score)
		return best_score
	else:
		var best_score = INF
		for i in range(9):
			if board[i] == 0:
				board[i] = Enums.Player.X
				var score = _minimax(board, true)
				board[i] = 0
				best_score = min(score, best_score)
		return best_score

func _get_winner_score(board: Array) -> Variant:
	# Check wins
	for combo in win_combinations:
		var a = combo[0]
		var b = combo[1]
		var c = combo[2]

		if board[a] != 0 and board[a] == board[b] and board[b] == board[c]:
			match board[a]:
				Enums.Player.O:
					return 10
				Enums.Player.X:
					return -10
				_:
					return 0

	# Check draw
	if not board.has(0):
		return 0

	return null
