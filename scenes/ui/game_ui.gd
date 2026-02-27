extends CanvasLayer
class_name GameUi

@export var game_manager: GameManager

@onready var btn_container: GridContainer = %GridContainer

var current_player: Enums.Player
var player_symbol = ""


func _ready() -> void:
	initialize()
	%Btn0.pressed.connect(_on_btn_pressed.bind(0,0, %Btn0))
	%Btn1.pressed.connect(_on_btn_pressed.bind(0,1, %Btn1))
	%Btn2.pressed.connect(_on_btn_pressed.bind(0,2, %Btn2))
	%Btn3.pressed.connect(_on_btn_pressed.bind(1,0, %Btn3))
	%Btn4.pressed.connect(_on_btn_pressed.bind(1,1, %Btn4))
	%Btn5.pressed.connect(_on_btn_pressed.bind(1,2, %Btn5))
	%Btn6.pressed.connect(_on_btn_pressed.bind(2,0, %Btn6))
	%Btn7.pressed.connect(_on_btn_pressed.bind(2,1, %Btn7))
	%Btn8.pressed.connect(_on_btn_pressed.bind(2,2, %Btn8))


func initialize() -> void:
	change_player(game_manager.current_player)
	for button in btn_container.get_children():
		if button is Button:
			button.text = ""
			button.disabled = false

func update_score(x_score: int, o_score: int) -> void:
	%XScoreLabel.text = "X: %s" % x_score
	%OScoreLabel.text = "O: %s" % o_score


func change_player(current_player: Enums.Player) -> void:
	current_player = current_player
	player_symbol = "X" if current_player == Enums.Player.X else "O"
	%TurnLabel.text = "Player %s turn." % ("X" if current_player == Enums.Player.X else "O")


func _on_btn_pressed(row: int, col: int, btn: GameButton) -> void:
	var color = (Color("#5bd170") if game_manager.current_player == Enums.Player.X else Color("5ac1f7ff"))
	btn.add_theme_color_override("font_disabled_color", color)
	btn.text = player_symbol
	btn.play_animation()
	btn.disabled = true
	game_manager.determine_winner(row, col)
	change_player(game_manager.current_player)
