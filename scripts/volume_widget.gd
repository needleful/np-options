extends Control

signal changed(opt_name, channel)

var opt_name: String
var channel: AudioChannel

func _ready():
	for c in get_children():
		c.focus_neighbor_left = c.get_path()
	$HSlider.connect("value_changed", Callable(self, "_on_volume_changed"))
	$mute.connect("toggled", Callable(self, "_on_mute_toggled"))

func _input(event: InputEvent):
	if ( visible
		and event.is_action_pressed('ui_accept')
		and $HSlider.has_focus()
	):
		$mute.button_pressed = !$mute.button_pressed

func set_option_hint(hints:Dictionary):
	opt_name = hints.name
	$name.text = opt_name.capitalize()

func set_option_value(val: AudioChannel):
	channel = val
	$HSlider.value = val.vol
	$mute.button_pressed = val.muted

func grab_focus():
	$HSlider.grab_focus()

func _on_mute_toggled(val: bool):
	if channel:
		channel.muted = val
		emit_signal('changed', opt_name, channel)

func _on_volume_changed(val:float):
	if channel:
		channel.vol = val
		$volLabel.text = '%.2f' % val
		emit_signal('changed', opt_name, channel)
