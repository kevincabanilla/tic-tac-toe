class_name OptionsMenu extends CanvasLayer

signal close

@onready var mode_button: Button = %ModeButton
@onready var difficulty_option_button: OptionButton = %DifficultyOptionButton
@onready var allow_draw_check_box: CheckBox = %AllowDrawCheckBox
@onready var close_button: Button = %CloseButton
@onready var difficulty_label: Label = %DifficultyLabel


func _ready() -> void:
	initialize_options()
	close_button.pressed.connect(_on_close_button_pressed)
	mode_button.pressed.connect(_mode_button_on_pressed)
	difficulty_option_button.item_selected.connect(_on_difficulty_option_button_item_selected)
	allow_draw_check_box.toggled.connect(_on_allow_draw_check_box_toggled)
	

func initialize_options() -> void:
	for key in Enums.Difficulty.keys():
		difficulty_option_button.add_item(key, Enums.Difficulty[key])
	match GameData.mode:
		Enums.Mode.AI:
			mode_button.text = "AI"
		Enums.Mode.TwoPlayer:
			mode_button.text = "With a Friend"
	difficulty_option_button.selected = Enums.Difficulty.values().find(GameData.difficulty)
	allow_draw_check_box.button_pressed = GameData.allow_draw
	update_difficulty_visibility()


func update_difficulty_visibility() -> void:
	var show_difficulty := GameData.mode == Enums.Mode.AI
	difficulty_label.visible = show_difficulty
	difficulty_option_button.visible = show_difficulty
	


func _mode_button_on_pressed() -> void:
	match GameData.mode:
		Enums.Mode.AI:
			mode_button.text = "With a Friend"
			GameData.mode = Enums.Mode.TwoPlayer
		Enums.Mode.TwoPlayer:
			mode_button.text = "AI"
			GameData.mode = Enums.Mode.AI
	update_difficulty_visibility()


func _on_difficulty_option_button_item_selected(index: int) -> void:
	var selected_item = Enums.Difficulty.values()[index] as Enums.Difficulty
	GameData.difficulty = selected_item


func _on_allow_draw_check_box_toggled(toggled_on: bool) -> void:
	GameData.allow_draw = toggled_on


func _on_close_button_pressed() -> void:
	GameData.save_data()
	close.emit()
	queue_free()
