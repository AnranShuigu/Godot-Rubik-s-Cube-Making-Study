extends Control

@onready var button_star = $Button

func _ready() -> void:
	Input.set_custom_mouse_cursor(全局变量.cursor_texture, Input.CURSOR_ARROW, Vector2(8, 8))
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

func _process(delta: float) -> void:
	pass

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://场景/选择界面.tscn")
	pass 

func _on_button_2_button_down() -> void:
	get_tree().quit()
	pass
