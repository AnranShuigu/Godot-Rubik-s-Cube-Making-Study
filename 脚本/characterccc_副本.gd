extends CharacterBody3D

@onready var 横 = $"横"
@onready var 竖 = $"竖"
@onready var 面 = $"面"
@onready var mesh : Array[Area3D] = [
	$"../Mesh/1",$"../Mesh/2",$"../Mesh/3", $"../Mesh/4", 
	$"../Mesh/5", $"../Mesh/6", $"../Mesh/7", $"../Mesh/8",
	$"../Mesh/9", $"../Mesh/10", $"../Mesh/11", $"../Mesh/12", 
	$"../Mesh/13", $"../Mesh/14", $"../Mesh/15", $"../Mesh/16", 
	$"../Mesh/17", $"../Mesh/18", $"../Mesh/19", $"../Mesh/20", 
	$"../Mesh/21", $"../Mesh/22", $"../Mesh/23", $"../Mesh/24", 
	$"../Mesh/25", $"../Mesh/26", $"../Mesh/27"
]
@onready var 层选择 = $"横/层选择"
@onready var 列选择 = $"竖/列选择"
@onready var 面选择 = $"面/深度选择"
@onready var camera1 = $Camera
@onready var camera2 = $Camera/Camera3D
@onready var 方块源 = $"../Mesh"

var cameron : bool

func _ready() -> void:
	for area in mesh:
		area.add_to_group("可检测区域")
	
	if Input.is_action_pressed("ESC"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	cameron = false

func _physics_process(delta: float) -> void:

	# R 键：层选择
	if Input.is_action_just_pressed("R"):
		横.visible = !横.visible
		横.set_process_mode(Node.PROCESS_MODE_INHERIT)
		竖.set_process_mode(Node.PROCESS_MODE_DISABLED)
		竖.visible = false
		面.set_process_mode(Node.PROCESS_MODE_DISABLED)
		面.visible = false

	# 层选择 鼠标左右键移动
	if 横.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			var 临时列表 = 层选择.get_children()
			for 子节点 in 临时列表:
				子节点.reparent(方块源)
			
			横.position.y += 2
			横.position.y = clamp(横.position.y, -2, 2)
			
			for 子节点 in 临时列表:
				子节点.reparent(层选择)

		if Input.is_action_just_pressed("鼠标右键"):
			var 临时列表 = 层选择.get_children()
			for 子节点 in 临时列表:
				子节点.reparent(方块源)
			
			横.position.y -= 2
			横.position.y = clamp(横.position.y, -2, 2)
			
			for 子节点 in 临时列表:
				子节点.reparent(层选择)

	# F 键：列选择
	if Input.is_action_just_pressed("F"):
		竖.visible = !竖.visible
		竖.set_process_mode(Node.PROCESS_MODE_INHERIT)
		面.set_process_mode(Node.PROCESS_MODE_DISABLED)
		面.visible = false
		横.set_process_mode(Node.PROCESS_MODE_DISABLED)
		横.visible = false

	# 列选择 鼠标左右键移动
	if 竖.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			var 临时列表 = 列选择.get_children()
			for 子节点 in 临时列表:
				子节点.reparent(方块源)
			
			竖.position.x += 2
			竖.position.x = clamp(竖.position.x, -2, 2)
			
			for 子节点 in 临时列表:
				子节点.reparent(列选择)

		if Input.is_action_just_pressed("鼠标右键"):
			var 临时列表 = 列选择.get_children()
			for 子节点 in 临时列表:
				子节点.reparent(方块源)
			
			竖.position.x -= 2
			竖.position.x = clamp(竖.position.x, -2, 2)
			
			for 子节点 in 临时列表:
				子节点.reparent(列选择)

	# C 键：面选择
	if Input.is_action_just_pressed("C"):
		面.visible = !面.visible
		面.set_process_mode(Node.PROCESS_MODE_INHERIT)
		横.set_process_mode(Node.PROCESS_MODE_DISABLED)
		横.visible = false
		竖.set_process_mode(Node.PROCESS_MODE_DISABLED)
		竖.visible = false

	# 面选择 鼠标左右键移动
	if 面.visible == true:
		if Input.is_action_just_pressed("鼠标左键"):
			var 临时列表 = 面选择.get_children()
			for 子节点 in 临时列表:
				子节点.reparent(方块源)
			
			面.position.z += 2
			面.position.z = clamp(面.position.z, 2, 6)
			
			for 子节点 in 临时列表:
				子节点.reparent(面选择)

		if Input.is_action_just_pressed("鼠标右键"):
			var 临时列表 = 面选择.get_children()
			for 子节点 in 临时列表:
				子节点.reparent(方块源)
			
			面.position.z -= 2
			面.position.z = clamp(面.position.z, 2, 6)
			
			for 子节点 in 临时列表:
				子节点.reparent(面选择)

	# A / D 旋转
	if Input.is_action_just_pressed("A"):
		层选择.rotation.y += PI/4
		列选择.rotation.x += PI/4
		面选择.rotation.z += PI/4

	if Input.is_action_just_pressed("D"):
		层选择.rotation.y -= PI/4
		列选择.rotation.x -= PI/4
		面选择.rotation.z -= PI/4

	# 相机控制
	var camer = Input.get_last_mouse_velocity()
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera1.rotation.y -= camer.x * 0.0001
		camera1.rotation.x += camer.y * 0.0001
		camera1.rotation.x = clamp(camera1.rotation.x, -PI/2, PI/2 - PI/3)

	# 滚轮缩放
	if Input.is_action_just_pressed("鼠标滚轮上"):
		camera1.scale -= Vector3(0.1, 0.1, 0.1)
		camera1.scale = clamp(camera1.scale, Vector3(0.5, 0.5, 0.5), Vector3(3, 3, 3))

	if Input.is_action_just_pressed("鼠标滚轮下"):
		camera1.scale += Vector3(0.1, 0.1, 0.1)
		camera1.scale = clamp(camera1.scale, Vector3(0.5, 0.5, 0.5), Vector3(3, 3, 3))

	# 鼠标显示切换
	if Input.is_action_just_pressed("鼠标中键") or Input.is_action_just_pressed("ESC"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# 碰撞检测
func _on_横_body_entered(body: Node3D) -> void:
	if body.is_in_group("可检测区域"):
		body.reparent(层选择)

func _on_竖_body_entered(body: Node3D) -> void:
	if body.is_in_group("可检测区域"):
		body.reparent(列选择)

func _on_面_body_entered(body: Node3D) -> void:
	if body.is_in_group("可检测区域"):
		body.reparent(面选择)
