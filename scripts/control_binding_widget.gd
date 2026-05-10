extends Control

signal changed(opt_name, value)

var option_name:String

func _ready():
	for c in get_children():
		c.focus_neighbor_left = c.get_path()
	$set.pressed.connect(_rebind_start)

func _rebind_start():
	pass

func set_option_hint(option:Dictionary):
	option_name = option.name

func set_option_value(val:ControlBinding):
	$action.text = val.action
	$input.text = val.input
