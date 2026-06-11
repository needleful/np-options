class_name ControlBindingWidget
extends Control

signal prompted(opt_name)
signal changed(opt_name, value)

var option_name:String
var value: Array

func _ready():
	for c in get_children():
		c.focus_neighbor_left = c.get_path()
		c.focus_neighbor_right = c.get_path()
	$set.pressed.connect(_rebind_start)
	add_to_group('input_prompt')

func _rebind_start():
	prompted.emit(option_name)

func set_option_hint(option:Dictionary):
	option_name = option.name
	$action.text = option.name.split('/')[1]

func set_option_value(val:Array):
	value = val
	_refresh()

func _refresh():
	if value:
		$key_prompt.depict(value[0], InputManagement.PromptMode.Keyboard)
		$gamepad_prompt.depict(value[1], InputManagement.gamepad_mode)
