
#=====================================================
#使用说明
#=====================================================
# 手机Godot 屏幕日志工具（无报错·稳定版）
# 使用说明：
# 1. 把这个脚本挂载到【场景根节点】（最上方的 Node2D）
# 2. 运行后自动在屏幕左上角显示日志
# 3. 可以在任意脚本使用get_parent().print_to_screen("内容")等方式调用，
#    将"内容“打印在屏幕上，前提是父节点是根节点
# 4. 也可以在任意脚本使用get_parent().add_log("内容")等方式调用，
#    将"内容“添加到日志中，前提是父节点是根节点 
# 5. 自动限制显示行数，超出会自动删除旧日志
# 6. 可在编辑器调整：行数、字体大小、文字颜色
#=====================================================

extends Node

# 日志设置
@export var max_lines = 15
@export var font_size = 18
@export var text_color = Color(1,1,1)

var log_label: Label
var log_lines: Array[String] = []
var canvas_layer: CanvasLayer

func _ready():
	# 先创建UI，保证一定存在
	create_log_label()
	add_log("日志启动成功")
	add_log("你好啊")

# 创建日志UI（最稳定写法）
func create_log_label():
	# 创建画布，保证显示在最上层
	canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100
	add_child(canvas_layer)

	# 创建文字标签
	log_label = Label.new()
	log_label.name = "ConsoleLog"
	log_label.position = Vector2(10, 10)
	log_label.add_theme_font_size_override("font_size", font_size)
	log_label.add_theme_color_override("font_color", text_color)
	
	canvas_layer.add_child(log_label)

# 打印日志（自动显示在屏幕）
func print_to_screen(msg: String):
	print(msg)  # 输出到控制台
	log_lines.append(msg)
	
	# 限制行数
	if log_lines.size() > max_lines:
		log_lines.pop_front()
	
	# 更新显示
	if log_label:
		var text = ""
		for line in log_lines:
			text += line + "\n"
		log_label.text = text

# 内部添加日志
func add_log(msg: String):
	print_to_screen(msg)
	

#=====================================================

## 逐行详细解释（超级易懂）##
##这是一个**手机 Godot 专用的屏幕日志脚本**，作用是：  
##**把控制台的打印内容，直接显示在游戏屏幕上**，不用看后台控制台。

#我给你一行一行讲清楚：

##```gdscript
# 这个脚本挂在任何节点上都能用，推荐挂根节点
#extends Node
#```

#---

## 一、可调整的设置（在编辑器里能改）
##```gdscript
# 日志设置
#@export var max_lines = 15      # 屏幕最多显示15行日志，多了自动删掉最旧的
#@export var font_size = 18     # 文字大小
#@export var text_color = Color(1,1,1)  # 文字颜色（白色）
##```

#---

## 二、内部用到的变量
##```gdscript
#var log_label: Label           # 用来显示文字的标签
#var log_lines: Array[String] = []  # 保存所有日志内容的列表
#var canvas_layer: CanvasLayer  # 让日志永远显示在游戏最上层
##```

#---

## 三、游戏启动时执行
##```gdscript
#func _ready():
#	create_log_label()  # 先创建显示日志的UI
#	add_log("日志启动成功")  # 打印日志
#	add_log("你好啊")       # 打印日志
#```

#---

## 四、自动创建屏幕日志UI（最重要）
##```gdscript
#func create_log_label():
#	# 新建一个“画布层”，让日志显示在最上面
#	canvas_layer = CanvasLayer.new()
#	canvas_layer.layer = 100  # 层级最高，不会被游戏画面挡住
#	add_child(canvas_layer)

	# 新建一个Label文字标签
#	log_label = Label.new()
#	log_label.position = Vector2(10, 10)  # 显示在屏幕左上角
#	log_label.add_theme_font_size_override("font_size", font_size)
#	log_label.add_theme_color_override("font_color", text_color)
	
#	canvas_layer.add_child(log_label)  # 把文字放进画布
#```

#---

## 五、打印日志到屏幕 + 控制台
##```gdscript
#func print_to_screen(msg: String):
#	print(msg)                # 输出到控制台
#	log_lines.append(msg)     # 把日志存进列表
	
	# 超过最大行数，删除最早的一行
#	if log_lines.size() > max_lines:
#		log_lines.pop_front()
	
	# 如果Label存在，更新显示内容
#	if log_label:
#		var text = ""
#		for line in log_lines:
#			text += line + "\n"
#		log_label.text = text
#```

#---

## 六、外部调用的日志函数
##```gdscript
#func add_log(msg: String):
#	print_to_screen(msg)
#```

#---

# 整体一句话总结
#**这个脚本就是一个“屏幕控制台”：**
#1. 自动在屏幕左上角创建文字
#2. 你调用 `add_log("内容")`
#3. 内容会同时显示在 **控制台 + 游戏屏幕**
#4. 自动限制行数，不会溢出
#5. 手机 Godot 专用，无报错、稳定运行

#---

# 你必须知道的使用方法
#在别的脚本里（比如玩家脚本）：
##```gdscript
#get_parent().add_log("左")
#get_parent().add_log("右")
#get_parent().add_log("你好啊")
#```
#这样就能在**屏幕上看到日志**了！

#=====================================================
