extends CharacterBody3D

@onready var 横 = $"横"
@onready var 竖 = $"竖"
@onready var 面 = $"面"

@onready var 层选择 = $"../顺序/层选择"
@onready var 列选择 = $"../顺序/列选择"
@onready var 面选择 = $"../顺序/面选择"

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
@onready var camera1 = $Camera

var cameron : bool
var 变量1 = true

func _ready() -> void:
	
	for area in mesh:
		add_to_group("可检测区域")
	if Input.is_action_pressed("ESC"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		print("ESC")
	cameron = false
	pass


func _input(event: InputEvent) -> void:
	# 简单 安全 不报错
	if Input.is_action_just_pressed("X"):
		print("X 键：清空所有选择器里的魔方")

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
			横.position.y = clamp(横.position.y,-2,2)
		if Input.is_action_just_pressed("鼠标右键"):
			横.position.y -= 2
			横.position.y = clamp(横.position.y,-2,2)
		
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
			竖.position.x = clamp(竖.position.x,-2,2)
		if Input.is_action_just_pressed("鼠标右键"):
			竖.position.x -= 2
			竖.position.x = clamp(竖.position.x,-2,2)

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
			面.position.z = clamp(面.position.z,2,6)
		if Input.is_action_just_pressed("鼠标右键"):
			for 子节点 in 层选择.get_children():
				print(子节点)
				子节点.reparent(mesh_parent)
			面.position.z -= 2
			面.position.z = clamp(面.position.z,2,6)

	#按下A D分别为顺时针和逆时针旋转
	if Input.is_action_just_pressed("A"):
		层选择.rotation.y -= PI/4
		列选择.rotation.x -= PI/4
		面选择.rotation.z -= PI/4
		print("A")
	if Input.is_action_just_pressed("D"):
		层选择.rotation.y += PI/4
		列选择.rotation.x += PI/4
		面选择.rotation.z += PI/4
		print("D")
	
	#获取鼠标速度
	var camer = Input.get_last_mouse_velocity()
	#print(camer)
	#如果鼠标模式为隐藏，则旋转xy
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera1.rotation.y -= camer.x * 0.01 * 0.01 * 0.1
		camera1.rotation.x += camer.y * 0.01 * 0.01 * 0.1
		#camera1.rotation.x = clamp(camera1.rotation.x,-PI/2 , PI/2-PI/3)
	#鼠标滚轮缩放
	if Input.is_action_just_pressed("鼠标滚轮上"):
		print("up")
		camera1.scale -= Vector3(0.1,0.1,0.1)
		camera1.scale = clamp(camera1.scale,Vector3(0.5,0.5,0.5),Vector3(3,3,3))
	if Input.is_action_just_pressed("鼠标滚轮下"):
		print("down")
		camera1.scale += Vector3(0.1,0.1,0.1)
		camera1.scale = clamp(camera1.scale,Vector3(0.5,0.5,0.5),Vector3(2,2,2))
	#ESC隐藏鼠标
	if Input.is_action_pressed("鼠标中键") or Input.is_action_pressed("ESC"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

var suo = false

func _on_横_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.reparent(层选择)
		print("层选择可检测区域横")
	pass # Replace with function body.

func _on_竖_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.reparent(列选择)
		print("列选择可检测区域横")
	pass # Replace with function body.


func _on_面_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.reparent(面选择)
		print("面选择可检测区域横")
	pass # Replace with function body.
	
func 放入():
	
	pass
