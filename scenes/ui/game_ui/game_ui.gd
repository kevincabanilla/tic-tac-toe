extends CanvasLayer
class_name GameUi

@export var game_manager: GameManager
@export var cross_line_scene: PackedScene

@onready var btn_container: GridContainer = %GridContainer
@onready var btn_0: Button = %Btn0
@onready var btn_1: Button = %Btn1
@onready var btn_2: Button = %Btn2
@onready var btn_3: Button = %Btn3
@onready var btn_4: Button = %Btn4
@onready var btn_5: Button = %Btn5
@onready var btn_6: Button = %Btn6
@onready var btn_7: Button = %Btn7
@onready var btn_8: Button = %Btn8
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ui_controls: UiControls = %UiControls
@onready var panel_container: PanelContainer = %PanelContainer

var current_player := Enums.Player.X
var cross_line_instance: CrossLine


func _ready() -> void:
	initialize()
	print("game_ui initialized.")
	btn_0.pressed.connect(_on_btn_pressed.bind(0,0, btn_0))
	btn_1.pressed.connect(_on_btn_pressed.bind(0,1, btn_1))
	btn_2.pressed.connect(_on_btn_pressed.bind(0,2, btn_2))
	btn_3.pressed.connect(_on_btn_pressed.bind(1,0, btn_3))
	btn_4.pressed.connect(_on_btn_pressed.bind(1,1, btn_4))
	btn_5.pressed.connect(_on_btn_pressed.bind(1,2, btn_5))
	btn_6.pressed.connect(_on_btn_pressed.bind(2,0, btn_6))
	btn_7.pressed.connect(_on_btn_pressed.bind(2,1, btn_7))
	btn_8.pressed.connect(_on_btn_pressed.bind(2,2, btn_8))
	#game_manager.game_over.connect(_on_game_manager_game_over)


func initialize() -> void:
	if cross_line_instance != null:
		cross_line_instance.queue_free()
	
	change_player(game_manager.current_player)
	for button in btn_container.get_children():
		if button is Button:
			button.text = ""
			button.disabled = false


func get_pivot_global_position(control: Control) -> Vector2:
	#return control.get_global_transform() * control.pivot_offset # use this if pivot is not centered
	return control.global_position + control.size / 2 # use this if pivot is already centered


func change_player(player: Enums.Player) -> void:
	current_player = player
	ui_controls.change_player(current_player)
	

func blur() -> void:
	animation_player.play("blur")
	#await animation_player.animation_finished


func restart() -> void:
	initialize()
	animation_player.play_backwards("blur")


func add_child_to_panel_container(node: Node) -> void:
	panel_container.add_child(node)


func display_cross_line() -> void:
	var result_index := game_manager.get_result_index().split("|")
	print(result_index)
	if result_index.size() != 2:
		return
	
	var index_1 := Array(result_index[0].split(":")).map(func(val): return int(val))
	var index_2 := Array(result_index[1].split(":")).map(func(val): return int(val))
	
	var btns := [
		[btn_0, btn_1, btn_2],
		[btn_3, btn_4, btn_5],
		[btn_6, btn_7, btn_8]
	]
	
	cross_line_instance = cross_line_scene.instantiate() as CrossLine
	cross_line_instance.duration = 0.6
	cross_line_instance.start_point = get_pivot_global_position(btns[index_1[0]][index_1[1]]) #Vector2.ZERO
	cross_line_instance.end_point = get_pivot_global_position(btns[index_2[0]][index_2[1]]) #Vector2(380, 380)
	$PanelContainer.add_child(cross_line_instance)
	await cross_line_instance.tween_animation.finished


func _on_btn_pressed(row: int, col: int, btn: GameButton) -> void:
	btn.text = "X" if current_player == Enums.Player.X else "O"
	btn.theme_type_variation = btn.text + "Button"
	btn.play_animation()
	btn.disabled = true
	change_player(game_manager.get_next_player(row, col))
