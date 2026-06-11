class_name ControlBinding

static func as_event(input: String) -> InputEvent:
	var e := input.split(':')
	var event: InputEvent
	match e[0]:
		'button':
			event = InputEventJoypadButton.new()
			event.button_index = int(e[1])
			event.pressed = true
		'axis':
			event = InputEventJoypadMotion.new()
			event.axis = int(e[1])
			event.axis_value = float(e[2])
		'key':
			event = InputEventKey.new()
			event.physical_keycode = int(e[1])
			event.pressed = true
		'mouse':
			event = InputEventMouseButton.new()
			event.button_index = int(e[1])
		_:
			push_error('Undefined input type: ', input)
			event = null
	return event

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
