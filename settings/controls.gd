extends Node
class_name ControlsSettings

signal prompts_changed(type)

@export var button_prompts := NPInputManager.PromptMode.AutoDetect: set = set_prompts
@export_range(0.1, 10.0, 0.1) var camera_sensitivity := 1.0
@export var invert_y := false
@export var invert_x := false
# String name to 2 InputEvents: [keyboard/mouse, gamepad]
var _bindings: Dictionary[StringName, Array]

var group_name := &'Controls'

var bindable: Array[StringName]
var default_bindings: Dictionary[StringName, Array]

func init_bindable(actions: Array[StringName]):
	bindable = actions
	for action in bindable:
		default_bindings[action] = [
			# Keyboard, then gamepad
			InputManagement.default_input_for_action(action, false),
			InputManagement.default_input_for_action(action, true)
		]
		if action not in _bindings:
			_bindings[action] = default_bindings[action]

func set_prompts(value):
	button_prompts = value
	prompts_changed.emit(value)

func _reset():
	print_debug('Rebiding controls')
	_bindings = default_bindings.duplicate()
	for b in _bindings:
		_rebind(b, _bindings[b])
	camera_sensitivity = 1.0
	invert_x = false
	invert_y = false
	button_prompts = InputManagement.PromptMode.AutoDetect

func _set(property: StringName, value: Variant) -> bool:
	if property.begins_with('bindings'):
		return _set_binding(property, value)
	else:
		return false

func _set_binding(id: StringName, value: Array) -> bool:
	var s := id.split('/', false)
	if s.size() != 2:
		push_error('Expected "%d" to be an array of form "name/index"' % id)
		return false
	var action_name := s[1]
	return _rebind(action_name, value)

func _rebind(action: String, value: Array) -> bool:
	_bindings[action] = value
	# Keyboard, then gamepad
	InputManagement.rebind(action, value[0], false)
	InputManagement.rebind(action, value[1], true)
	return true

func _get(property: StringName) -> Variant:
	if property.begins_with('bindings'):
		return _get_binding(property)
	else:
		return null

func _get_binding(id: StringName) -> Variant:
	var s := id.split('/', false)
	if s.size() != 2:
		push_error('Expected "%d" to be an array of form "name/index"' % id)
		return null
	var index := s[1]
	return _bindings[index]

func _get_property_list() -> Array[Dictionary]:
	var p :Array[Dictionary] = []
	for s in bindable:
		p.append(_binding_info('bindings/'+s))
	return p

func _binding_info(p_name: String) -> Dictionary:
	return {
		'name':p_name,
		# Custom type
		'type': TYPE_ARRAY,
		'usage': Settings.USAGE_FLAGS,
		'hint': '',
		'hint_string': 'binding'
	}

func encode(property: StringName) -> Variant:
	var event := _get(property)
	if event:
		return [
			ControlBinding.as_string(event[0]),
			ControlBinding.as_string(event[1])
		]
	else:
		return get(property)

func decode(property: StringName, value) -> void:
	if property.begins_with('bindings'):
		_set(property, [
			ControlBinding.as_event(value[0]),
			ControlBinding.as_event(value[1])
		])
	else:
		set(property, value)
