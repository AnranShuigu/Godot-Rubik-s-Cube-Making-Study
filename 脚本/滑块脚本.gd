extends HSlider

@export var display_label: Label

func _ready():
	update_label(value)
	value_changed.connect(update_label)

func update_label(val):
	# 这行是修复后的正确写法，绝对不报错
	display_label.text = str(round(val * 10) / 10) 
	全局变量.阶数 = int(display_label.text)
