extends Node

@export var 阶数 = 2

# 加载你的鼠标图片
var cursor_texture = load("res://cursor.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(12):
		print(1)
	# 设置自定义鼠标（第二个参数是热点，一般设为 0,0 或 8,8）
	Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW, Vector2(8, 8))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 
