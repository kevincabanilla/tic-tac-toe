extends Node

signal open_options_menu()
signal game_over(winner: Enums.Player)
signal game_draw()


func disable_all_input(disable: bool) -> void:
	get_viewport().gui_disable_input = disable
