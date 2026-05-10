class_name ControlBinding

static func default(p_action: String, gamepad: bool) -> String:
	return as_string(InputManagement.default_input_for_action(p_action, gamepad))

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
