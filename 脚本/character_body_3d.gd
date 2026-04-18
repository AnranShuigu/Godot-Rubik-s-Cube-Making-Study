@tool
extends CharacterBody3D
#变量
#region

	#region
	# 平滑旋转专用变量
	#var target_rot_y: float = 0.0
	#var target_rot_x: float = 0.0
	#var target_rot_z: float = 0.0
	#const ROT_SPEED = 8.0 # 旋转速度，越大转越快
	#endregion

@onready var 横 = $"横"
@onready var 竖 = $"竖"
@onready var 面 = $"面"

@onready var 层选择 = $"../顺序/层选择"
@onready var 列选择 = $"../顺序/列选择"
@onready var 面选择 = $"../顺序/面选择"

@onready var 横_collsion = $"横/CollisionShape3D"
@onready var 竖_collsion = $"竖/CollisionShape3D"
@onready var 面_collsion = $"面/CollisionShape3D"

@onready var mesh : Array[Area3D] = [
	$"../Mesh/1",$"../Mesh/2",$"../Mesh/3", $"../Mesh/4", 
	$"../Mesh/5", $"../Mesh/6", $"../Mesh/7", $"../Mesh/8",
	$"../Mesh/9", $"../Mesh/10", $"../Mesh/11", $"../Mesh/12", 
	$"../Mesh/13", $"../Mesh/14", $"../Mesh/15", $"../Mesh/16", 
	$"../Mesh/17", $"../Mesh/18", $"../Mesh/19", $"../Mesh/20", 
	$"../Mesh/21", $"../Mesh/22", $"../Mesh/23", $"../Mesh/24", 
	$"../Mesh/25", $"../Mesh/26", $"../Mesh/27"
	]
@onready var mesh_parent = $"../Mesh"
@onready var allmesh_one = $"../AllMesh_ONE/魔方"
@onready var camera1 = $Camera
@onready var camera2 = $Camera/Camera3D
@onready var 横_mesh = $"横"
@onready var 竖_mesh = $"竖"
@onready var 面_mesh = $"面"
@onready var world = $"../环境/MeshInstance3D"

@export var 阶数 = 2
@export var update := false

var mesh_数量 = 4
var cameron : bool
var 变量1 := false
#endregion

#初始化魔方
#region
func _ready() -> void:
	Input.set_custom_mouse_cursor(全局变量.cursor_texture, Input.CURSOR_ARROW, Vector2(8, 8))
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	for x in range(全局变量.阶数):
		for y in range(全局变量.阶数):
			for z in range(全局变量.阶数):
				var copy = allmesh_one.duplicate(true)
				copy.position = Vector3(x * 2, y * 2, z * 2)
				copy.visible = true
				copy.set_process_mode(Node.PROCESS_MODE_INHERIT)
				mesh_parent.add_child(copy)
				
	横_mesh.scale = Vector3(全局变量.阶数 , 1 , 全局变量.阶数)
	横_mesh.position = Vector3(全局变量.阶数-1 , 0 , 全局变量.阶数-1)
	
	竖_mesh.scale = Vector3(1 , 全局变量.阶数 , 全局变量.阶数)
	竖_mesh.position = Vector3(0 , 全局变量.阶数-1 , 全局变量.阶数-1 )
	
	面_mesh.scale = Vector3(全局变量.阶数 , 全局变量.阶数 , 1)
	面_mesh.position = Vector3(全局变量.阶数-1 , 全局变量.阶数-1 , 0)
	
	mesh_数量 = 全局变量.阶数 * 全局变量.阶数 * 全局变量.阶数
	
	camera1.position = Vector3(全局变量.阶数-1,全局变量.阶数-1,全局变量.阶数-1)
	camera2.position = Vector3(0,0,全局变量.阶数*2*3)
	
	层选择.position = Vector3(全局变量.阶数-1 , 0 , 全局变量.阶数-1)
	列选择.position = Vector3(0 , 全局变量.阶数-1 , 全局变量.阶数-1)
	面选择.position = Vector3(全局变量.阶数-1 , 全局变量.阶数-1 , 0)
	
	横_collsion.scale = Vector3(全局变量.阶数*4,1.8,全局变量.阶数*4)
	竖_collsion.scale = Vector3(1.8,全局变量.阶数*4,全局变量.阶数*4)
	面_collsion.scale = Vector3(全局变量.阶数*4,全局变量.阶数*4,1.8)
	
	for area in mesh:
		add_to_group("可检测区域")
	cameron = false
	pass
	
	#region
	 # 初始化角度
	#target_rot_y = 层选择.rotation.y
	#target_rot_x = 列选择.rotation.x
	#target_rot_z = 面选择.rotation.z
	
	#world.scale *= 全局变量.阶数
	
	#mesh_parent.scale = Vector3(2/全局变量.阶数+2,2/全局变量.阶数+2,2/全局变量.阶数+2)
	#endregion
#endregion

#region
#func rotate_smooth(node: Node3D, axis: Vector3, angle: float):
#	var tween = create_tween()
#	tween.tween_property(node, "rotation", node.rotation + axis * angle, 0.2)
#	tween.set_ease(Tween.EASE_OUT)
#endregion

#控制部分
#region
func _input(event: InputEvent) -> void:
	# 简单 安全 不报错
	if Input.is_action_just_pressed("X"):
		print("X 键：清空所有选择器里的魔方")
	if Input.is_action_just_pressed("鼠标中建"):
		变量1 = !变量1
		if 变量1:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			print("鼠标已隐藏")
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			print("鼠标已显示")
		
		# 清空 层选择
	if 层选择 != null:
		for child in 层选择.get_children():
			if child is CharacterBody3D and child != self:
				child.reparent(mesh_parent)

		# 清空 列选择
		if 列选择 != null:
			for child in 列选择.get_children():
				if child is CharacterBody3D and child != self:
					child.reparent(mesh_parent)

		# 清空 面选择
		if 面选择 != null:
			for child in 面选择.get_children():
				if child is CharacterBody3D and child != self:
					child.reparent(mesh_parent)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ESC"):
		get_tree().change_scene_to_file("res://场景/主场景.tscn")
	
	if update:
		update = false
	Input.action_press("X")
	#按下R F C键选择要旋转的面
	if Input.is_action_just_pressed("R"):
		print("层")
		for child in 层选择.get_children():
			child.reparent(mesh_parent)
		横.visible = !横.visible 
		横.set_process_mode(Node.PROCESS_MODE_INHERIT)
		竖.set_process_mode(Node.PROCESS_MODE_DISABLED)
		竖.visible = false
		面.set_process_mode(Node.PROCESS_MODE_DISABLED)
		面.visible = false
	if 横.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			横.position.y += 2
			横.position.y = clamp(横.position.y,0,全局变量.阶数*2-2)
		if Input.is_action_just_pressed("鼠标右键"):
			横.position.y -= 2
			横.position.y = clamp(横.position.y,0,全局变量.阶数*2-2)
		
	if Input.is_action_just_pressed("F"):
		print("竖")
		竖.visible = !竖.visible
		竖.set_process_mode(Node.PROCESS_MODE_INHERIT)
		面.set_process_mode(Node.PROCESS_MODE_DISABLED)
		面.visible = false
		横.set_process_mode(Node.PROCESS_MODE_DISABLED)
		横.visible = false
	if 竖.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			竖.position.x += 2
			竖.position.x = clamp(竖.position.x,0,全局变量.阶数*2-2)
		if Input.is_action_just_pressed("鼠标右键"):
			竖.position.x -= 2
			竖.position.x = clamp(竖.position.x,0,全局变量.阶数*2-2)

	if Input.is_action_just_pressed("C"):
		print("面")
		面.visible = !面.visible
		面.set_process_mode(Node.PROCESS_MODE_INHERIT)
		横.set_process_mode(Node.PROCESS_MODE_DISABLED)
		横.visible = false
		竖.set_process_mode(Node.PROCESS_MODE_DISABLED)
		竖.visible = false
	if 面.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			for 子节点 in 层选择.get_children():
				print(子节点)
				子节点.reparent(mesh_parent)
			面.position.z += 2
			面.position.z = clamp(面.position.z,0,全局变量.阶数*2-2)
		if Input.is_action_just_pressed("鼠标右键"):
			for 子节点 in 层选择.get_children():
				print(子节点)
				子节点.reparent(mesh_parent)
			面.position.z -= 2
			面.position.z = clamp(面.position.z,0,全局变量.阶数*2-2)
	#region
	# ============= 平滑旋转 =============
	# 层选择（Y轴）
	#层选择.rotation.y = lerp(层选择.rotation.y, target_rot_y, delta * ROT_SPEED)
	# 列选择（X轴）
	#列选择.rotation.x = lerp(列选择.rotation.x, target_rot_x, delta * ROT_SPEED)
	# 面选择（Z轴）
	#面选择.rotation.z = lerp(面选择.rotation.z, target_rot_z, delta * ROT_SPEED)
	# ============= A/D 按键只改目标角度 =============
	#if Input.is_action_just_pressed("A"):
	#	target_rot_y -= PI / 2
	#	target_rot_x -= PI / 2
	#	target_rot_z -= PI / 2
	#	print("A 逆时针")
	#	
	#if Input.is_action_just_pressed("D"):
	#	target_rot_y += PI / 2
	#	target_rot_x += PI / 2
	#	target_rot_z += PI / 2
	#	print("D 顺时针")
	#endregion
	#按下A D分别为顺时针和逆时针旋转
	if Input.is_action_just_pressed("A"):
		层选择.rotation.y -= PI/4
	#	横.rotation.y -= PI/4
		列选择.rotation.x -= PI/4
	#	竖.rotation.x -= PI/4
		面选择.rotation.z -= PI/4
		#面.rotation.z -= PI/4
		print("A")
	if Input.is_action_just_pressed("D"):
		层选择.rotation.y += PI/4
	#	横.rotation.y += PI/4
		列选择.rotation.x += PI/4
	#	竖.rotation.x += PI/4
		面选择.rotation.z += PI/4
	#	面.rotation.z += PI/4
		print("D")

	#region
	# 按键触发
	#if Input.is_action_just_pressed("A"):
	#	rotate_smooth(层选择, Vector3.UP, -PI/2)
	#	rotate_smooth(列选择, Vector3.RIGHT, -PI/2)
	#	rotate_smooth(面选择, Vector3.FORWARD, -PI/2)

	#if Input.is_action_just_pressed("D"):
	#	rotate_smooth(层选择, Vector3.UP, PI/2)
	#	rotate_smooth(列选择, Vector3.RIGHT, PI/2)
	#	rotate_smooth(面选择, Vector3.FORWARD, PI/2)
	#endregion
	#获取鼠标速度
	var camer = Input.get_last_mouse_velocity()
	#print(camer)
	#如果鼠标模式为隐藏，则旋转xy
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera1.rotation.y -= camer.x * 0.01 * 0.01 * 0.1
		camera1.rotation.x -= camer.y * 0.01 * 0.01 * 0.1
		#camera1.rotation.x = clamp(camera1.rotation.x,-PI/2 , PI/2-PI/3)
	#鼠标滚轮缩放
	if Input.is_action_just_pressed("鼠标滚轮上"):
		print("up")
		camera1.scale -= Vector3(0.1,0.1,0.1)
		camera1.scale = clamp(camera1.scale,Vector3(0.5,0.5,0.5),Vector3(3,3,3))
	if Input.is_action_just_pressed("鼠标滚轮下"):
		print("down")
		camera1.scale += Vector3(0.1,0.1,0.1)
		camera1.scale = clamp(camera1.scale,Vector3(0.5,0.5,0.5),world.scale*0.001)
		
#area检测部分
#region
func _on_横_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("_on_横_body_entered")
		body.reparent(层选择)
	pass # Replace with function body.

func _on_竖_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("_on_竖_body_entered")
		body.reparent(列选择)
	pass # Replace with function body.

func _on_面_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("_on_面_body_entered")
		body.reparent(面选择)
	pass # Replace with function body.
	
#endregion
