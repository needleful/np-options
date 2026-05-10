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
# String name to 2 InputEvents: [keyboard/mouse, gamepad]
var bindings: Dictionary[StringName, Array]

var group_name := &'Controls'

var bindable: Array[StringName]

func init_bindable(actions: Array[StringName]):
	bindable = actions
	for action in bindable:
		bindings[action] = [
			InputManagement.default_input_for_action(action, false),
			InputManagement.default_input_for_action(action, true)
		]

func set_prompts(value):
	button_prompts = value
	prompts_changed.emit(value)

func _set(property: StringName, value: Variant) -> bool:
	if property.begins_with('bindings'):
		return _set_binding(bindings, property, value)
	else:
		return false

func _set_binding(
	a: Dictionary[StringName, Array], id: StringName, value: Array
) -> bool:
	var s := id.split('/', false)
	if s.size() != 2:
		push_error('Expected "%d" to be an array of form "name/index"' % id)
		return false
	var index := s[1]
	a[index] = value
	return true

func _get(property: StringName) -> Variant:
	if property.begins_with('bindings'):
		return _get_binding(bindings, property)
	else:
		return null

func _get_binding(
	a: Dictionary[StringName, Array], id: StringName
) -> Variant:
	var s := id.split('/', false)
	if s.size() != 2:
		push_error('Expected "%d" to be an array of form "name/index"' % id)
		return null
	var index := s[1]
	return a[index]

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
