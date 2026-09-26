extends Control

signal changed(opt_name, value)

@onready var value: CheckBox = $value

var option_name:String
var disable_message := ''

func _ready():
	for c in get_children():
		c.focus_neighbor_left = c.get_path()
	value.pressed.connect(_on_value_pressed)

func set_option_hint(option:Dictionary):
	option_name = option.name
	$name.text = option_name.capitalize()

func set_option_value(val:bool):
	value.button_pressed = val

func grab_focus():
	value.grab_focus()

func _on_value_pressed():
	changed.emit(option_name, value.button_pressed)

func enable():
	value.disabled = false
	value.tooltip_text = ''
	$name.tooltip_text = ''

func disable(reason: String):
	value.disabled = true
	var r := tr(reason)
	$name.tooltip_text = r
	value.tooltip_text = r
