extends Node

@export var 阶数 = 42
@onready var mesh_instance_3d: MeshInstance3D = $环境/MeshInstance3D

func _ready() -> void:
	print("阶数 = ",阶数)
	pass 
