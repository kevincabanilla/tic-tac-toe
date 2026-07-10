class_name UiControls extends Control


func _ready() -> void:
	%MenuButton.visible = !GameData.fixed_setting
	GameData.player_score_updated.connect(_on_player_score_updated)


func update_score(player: Enums.Player, new_score: int) -> void:
	match player:
		Enums.Player.X:
			%XScoreLabel.text = "X: %s" % new_score
		Enums.Player.O:
			%OScoreLabel.text = "O: %s" % new_score


func change_player(player: Enums.Player) -> void:
	%TurnLabel.text = "Player %s turn." % ("X" if player == Enums.Player.X else "O")


func enable(is_enabled: bool) -> void:
	%MenuButton.disabled = !is_enabled


func _on_player_score_updated(player: Enums.Player, new_score: int) -> void:
	update_score(player, new_score)


func _on_menu_button_pressed() -> void:
	GameEvents.open_options_menu.emit()
