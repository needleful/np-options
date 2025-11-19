extends Node
class_name ControlsSettings

enum Prompts {
	AutoDetect,
	Gamepad,
	Keyboard
}

@export var button_prompts: Prompts = Prompts.AutoDetect: set = set_prompts
@export_range(0.1, 10.0, 0.1) var camera_sensitivity := 1.0
@export var invert_x := false
@export var invert_y := false
var group_name := &'Controls'

func set_prompts(value):
	button_prompts = value
	if button_prompts != Prompts.AutoDetect:
		InputManagement.using_gamepad = button_prompts == Prompts.Gamepad
	get_tree().call_group('input_prompt', '_refresh')
