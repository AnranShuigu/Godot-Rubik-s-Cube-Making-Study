extends CharacterBody3D

func  _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("A"):
		print("A")
		await get_tree().create_timer(0.2).timeout
		create_tween().tween_property(self,"rotation:y",rotation.y+PI/2,0.1)
	if Input.is_action_just_pressed("D"):
		print("D")
		await get_tree().create_timer(0.2).timeout
		create_tween().tween_property(self,"rotation:y",rotation.y-PI/2,0.1)
		
	if Input.is_action_just_pressed("X"):
		rotation = Vector3(0,0,0)
	pass
