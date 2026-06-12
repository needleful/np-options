class_name GroupSpacer
extends Container

@export var group_name: String:
	set(n):
		group_name = n
		if is_inside_tree():
			$Label.text = n

@export var line_style: StyleBox:
	set(p):
		line_style = p
		if p and is_inside_tree():
			$Panel.add_theme_stylebox_override('panel', p)

func _ready():
	group_name = group_name
	line_style = line_style
