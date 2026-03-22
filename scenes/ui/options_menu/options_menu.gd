class_name OptionsMenu extends CanvasLayer

signal close

@onready var close_button: Button = %CloseButton


func _ready() -> void:
	close_button.pressed.connect(_on_close_button_pressed)


func _on_close_button_pressed() -> void:
	close.emit()
	queue_free()
