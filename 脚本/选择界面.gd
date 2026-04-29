extends Control

func _ready() -> void:
	Input.set_custom_mouse_cursor(全局变量.cursor_texture, Input.CURSOR_ARROW, Vector2(8, 8))
	print(全局变量.阶数)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass 

#按钮代码
#region
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ESC"):
		get_tree().change_scene_to_file("res://场景/主场景.tscn")
	pass

func _on__button_down1() -> void:
	全局变量.阶数 = 2
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass

func _on__button_down2() -> void:
	全局变量.阶数 = 3
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass

func _on__button_down3() -> void:
	全局变量.阶数 = 4
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass

func _on__button_down4() -> void:
	全局变量.阶数 = 5
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass 

func _on__button_down5() -> void:
	全局变量.阶数 = 6
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass 
	
func _on__button_down6() -> void:
	全局变量.阶数 = 7
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass 
	
func _on__button_down7() -> void:
	全局变量.阶数 = 8
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass 

func _on__button_down8() -> void:
	全局变量.阶数 = 9
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass 

func _on__button_down9() -> void:
	全局变量.阶数 = 10
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass 

func _on__button_down10() -> void:
	全局变量.阶数 = 11
	get_tree().change_scene_to_file("res://场景/魔方总.tscn")
	pass
#endregion
