extends Control

signal changed(opt_name, value)

var option_name:String

func _ready():
	for c in get_children():
		c.focus_neighbor_left = c.get_path()
	$value.connect("pressed", Callable(self, "_on_value_pressed"))

func set_option_hint(option:Dictionary):
	option_name = option.name
	$name.text = option_name.capitalize()

func set_option_value(val:bool):
	$value.button_pressed = val

func grab_focus():
	$value.grab_focus()

func _on_value_pressed():
	emit_signal('changed', option_name, $value.button_pressed)
