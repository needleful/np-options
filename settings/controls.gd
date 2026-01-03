extends Node
class_name ControlsSettings

signal prompts_changed(type)

enum PromptMode {
	AutoDetect,
	Keyboard,
	# Unknown gamepad
	GenericGamepad,
	# XBox buttons
	XBox,
	Playstation,
	# Gamecube/Switch-style buttons
	Nintendo
}

@export var button_prompts: PromptMode = PromptMode.AutoDetect: set = set_prompts
@export_range(0.1, 10.0, 0.1) var camera_sensitivity := 1.0
@export var invert_x := false
@export var invert_y := false
var group_name := &'Controls'

func set_prompts(value):
	button_prompts = value
	prompts_changed.emit(value)
