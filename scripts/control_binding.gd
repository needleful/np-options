class_name ControlBinding
extends Resource

@export var action: String
# A string representing the input
@export var input: String

func _init():
	resource_name = 'ControlBinding'

static func default(p_action: String, gamepad: bool) -> ControlBinding:
	var cb := ControlBinding.new()
	cb.action = p_action
	cb.input = as_string(InputManagement.get_input_for_action(p_action, gamepad))
	return cb

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
		subtype = str(event.keycode)
	elif event is InputEventMouseButton:
		type = 'mouse'
		subtype = str(event.button_index)
	else:
		type = 'generic'
		subtype = event.as_text()
	return '%s:%s' % [type, subtype]
