extends HBoxContainer

signal preview_change(opt_name, value)
signal changed(opt_name, value)

var option_name:String

var dragging := false

func _ready():
	for c in get_children():
		c.focus_neighbor_left = c.get_path()
	$value/slider.drag_started.connect(_start_drag)
	$value/slider.drag_ended.connect(_end_drag)
	$value/slider.value_changed.connect(_on_value_changed)

func set_option_hint(option:Dictionary):
	if option.hint == PROPERTY_HINT_RANGE:
		var hint:PackedStringArray = option.hint_string.split(',')
		$value/slider.min_value = float(hint[0])
		$value/slider.max_value = float(hint[1])
		if hint.size() == 3:
			$value/slider.step = float(hint[2])
	option_name = option.name
	$name.text = option_name.capitalize()

func set_option_value(val:float):
	$value/label.text = str(val)
	$value/slider.value = val

func grab_focus():
	$value/slider.grab_focus()

func _start_drag():
	dragging = true

func _end_drag(value_changed: bool):
	dragging = false
	if value_changed:
		changed.emit(option_name, $value/slider.value)

func _on_value_changed(value):
	$value/label.text = str(value)
	if dragging:
		preview_change.emit(option_name, value)
	else:
		changed.emit(option_name, value)
