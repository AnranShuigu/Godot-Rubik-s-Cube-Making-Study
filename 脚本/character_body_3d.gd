@tool
extends CharacterBody3D

#变量
#region
@onready var 横 := $"横"
@onready var 竖 := $"竖"
@onready var 面 := $"面"

@onready var 层选择 := $"../顺序/层选择"
@onready var 列选择 := $"../顺序/列选择"
@onready var 面选择 := $"../顺序/面选择"

@onready var 横_collsion := $"横/CollisionShape3D"
@onready var 竖_collsion := $"竖/CollisionShape3D"
@onready var 面_collsion := $"面/CollisionShape3D"

@onready var mesh_parent := $"../Mesh"
@onready var allmesh_one := $"../AllMesh_ONE/魔方"
@onready var camera1 := $Camera
@onready var camera2 := $Camera/Camera3D
@onready var 横_mesh := $"横"
@onready var 竖_mesh := $"竖"
@onready var 面_mesh := $"面"
@onready var world := $"../环境/MeshInstance3D"

@export var update := false

var mesh_数量 := 4
var cameron : bool
var 变量1 := false

var update_横 := true
var update_竖 := true
var update_面 := true
#endregion


#初始化魔方
#region
func _ready() -> void:
	Input.set_custom_mouse_cursor(全局变量.cursor_texture, Input.CURSOR_ARROW, Vector2(8, 8))
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
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
	pass
#endregion


#控制部分
#region
func _旋转选择函数():
	#按下R F C键选择要旋转的面
#===========================================================================================
#===========================================================================================
	if Input.is_action_just_pressed("R"):
		if update_横 != update_横:
			update_横 = !update_横
			print("update_横")
		print("层")
		for child in 层选择.get_children():
			child.reparent(mesh_parent)
		横.visible = !横.visible 
		横.set_process_mode(Node.PROCESS_MODE_INHERIT)
		竖.set_process_mode(Node.PROCESS_MODE_DISABLED)
		竖.visible = false
		面.set_process_mode(Node.PROCESS_MODE_DISABLED)
		面.visible = false
#===========================================================================================
	if 横.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			update_横 = false
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
			横.position.y += 2
			横.position.y = clamp(横.position.y,0,全局变量.阶数*2-2)
			update_横 = true
		if Input.is_action_just_pressed("鼠标右键"):
			update_横 = false
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
#===========================================================================================
#===========================================================================================

	if Input.is_action_just_pressed("F"):
		if update_竖 != update_竖:
			update_竖 = !update_竖
		print("竖")
		竖.visible = !竖.visible
		竖.set_process_mode(Node.PROCESS_MODE_INHERIT)
		面.set_process_mode(Node.PROCESS_MODE_DISABLED)
		面.visible = false
		横.set_process_mode(Node.PROCESS_MODE_DISABLED)
		横.visible = false
#===========================================================================================
	if 竖.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			update_竖 = false
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
			竖.position.x += 2
			竖.position.x = clamp(竖.position.x,0,全局变量.阶数*2-2)
			update_竖 = true
		if Input.is_action_just_pressed("鼠标右键"):
			update_竖 = false
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
			竖.position.x -= 2
			竖.position.x = clamp(竖.position.x,0,全局变量.阶数*2-2)
			update_竖 = true
#===========================================================================================
#===========================================================================================

	if Input.is_action_just_pressed("C"):
		if update_面 != update_面:
			update_面 = !update_面
		print("面")
		面.visible = !面.visible
		面.set_process_mode(Node.PROCESS_MODE_INHERIT)
		横.set_process_mode(Node.PROCESS_MODE_DISABLED)
		横.visible = false
		竖.set_process_mode(Node.PROCESS_MODE_DISABLED)
		竖.visible = false
#===========================================================================================
	if 面.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			update_面 = false
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
			面.position.z += 2
			面.position.z = clamp(面.position.z,0,全局变量.阶数*2-2)
			update_面 = true
		if Input.is_action_just_pressed("鼠标右键"):
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
			面.position.z -= 2
			面.position.z = clamp(面.position.z,0,全局变量.阶数*2-2)
			update_面 = true
#===========================================================================================
#===========================================================================================

func _旋转函数():
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

func 鼠标操作():
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
		


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ESC"):
		get_tree().change_scene_to_file("res://场景/主场景.tscn")
	
	#按下R F C键选择要旋转的面
	_旋转选择函数()

	#按下A D分别为顺时针和逆时针旋转
	_旋转函数()

	#获取鼠标速度
	鼠标操作()
#endregion


#area检测部分
#region
func _on_横_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and update_横 == true:
		print("_on_横_body_entered")
		body.reparent(层选择)
	pass # Replace with function body.

func _on_竖_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and update_竖 == true:
		print("_on_竖_body_entered")
		body.reparent(列选择)
	pass # Replace with function body.

func _on_面_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and update_面 == true:
		print("_on_面_body_entered")
		body.reparent(面选择)
	pass # Replace with function body.
	
#endregion
