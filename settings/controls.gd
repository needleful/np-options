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
var keyboard_bindings: Array[ControlBinding]
var gamepad_bindings: Array[ControlBinding]

var group_name := &'Controls'

func set_prompts(value):
	button_prompts = value
	prompts_changed.emit(value)

func _set(property: StringName, value: Variant) -> bool:
	if property.begins_with('keyboard_bindings'):
		return _set_binding(keyboard_bindings, property, value)
	elif property.begins_with('gamepad_bindings'):
		return _set_binding(keyboard_bindings, property, value)
	else:
		return false

func _set_binding(a: Array, id: StringName, value: Variant) -> bool:
	var s := id.split('/', false)
	if s.size() != 2:
		push_error('Expected "%d" to be an array of form "name/index"' % id)
		return false
	var index := int(s[1])
	a[index] = value
	return true

func _get(property: StringName) -> Variant:
	if property.begins_with('keyboard_bindings'):
		return _get_binding(keyboard_bindings, property)
	elif property.begins_with('gamepad_bindings'):
		return _get_binding(keyboard_bindings, property)
	else:
		return null

func _get_binding(a: Array, id: StringName) -> Variant:
	var s := id.split('/', false)
	if s.size() != 2:
		push_error('Expected "%d" to be an array of form "name/index"' % id)
		return false
	var index := int(s[1])
	return a[index]

func _get_property_list() -> Array[Dictionary]:
	var p :Array[Dictionary] = []
	for k in keyboard_bindings.size():
		p.append(_property_info(keyboard_bindings[k], 'keyboard_bindings/'+str(k)))
	for g in gamepad_bindings.size():
		p.append(_property_info(gamepad_bindings[g], 'gamepad_bindings/'+str(g)))
	return p

func _property_info(b: ControlBinding, p_name: String) -> Dictionary:
	return {
		'name':p_name,
		'type': TYPE_OBJECT,
		'usage': Settings.USAGE_FLAGS,
		'hint': 0,
		'property_hint_string': ''
	}
