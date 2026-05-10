extends Control

signal changed(opt_name, value)

var option_name:String

func _ready():
	for c in get_children():
		c.focus_neighbor_left = c.get_path()
		c.focus_neighbor_right = c.get_path()
	$set.pressed.connect(_rebind_start)

func _rebind_start():
	print_debug('Rebinding ', option_name)

func set_option_hint(option:Dictionary):
	option_name = option.name
	$action.text = option.name.split('/')[1]

func set_option_value(val:Array):
	$key_prompt.depict(val[0], InputManagement.PromptMode.Keyboard)
	$gamepad_prompt.depict(val[1], InputManagement.gamepad_mode)
