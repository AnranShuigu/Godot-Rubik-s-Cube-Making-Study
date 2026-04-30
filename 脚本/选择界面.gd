extends Control

@onready var 选择界面: Control = $"."

func _ready() -> void:
	print(全局变量.阶数)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass 

func _on_开始按钮_pressed() -> void:
	print("开始游戏")
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass
