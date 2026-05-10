class_name ControlBinding

static func as_event(input: String) -> InputEvent:
	var e := input.split(':')
	match e[0]:
		'button':
			return InputEventJoypadButton.new()
		'axis':
			return InputEventJoypadMotion.new()
		'key':
			return InputEventKey.new()
		'mouse':
			return InputEventMouseButton.new()
		_:
			push_error('Undefined input type: ', input)
			return null

static func as_string(event: InputEvent) -> String:
	var type := 'button'
	var subtype := 'nothing'
	if event is InputEventJoypadButton:
		type = 'button'
		subtype = str(event.button_index)
	elif event is InputEventJoypadMotion:
		type = 'axis'
		subtype = '%s:%s' % [str(event.axis), str(sign(event.axis_value))]
	elif event is InputEventKey:
		type = 'key'
		subtype = str(event.physical_keycode)
	elif event is InputEventMouseButton:
		type = 'mouse'
		subtype = str(event.button_index)
	else:
		type = 'generic'
		subtype = event.as_text()
	return '%s:%s' % [type, subtype]
