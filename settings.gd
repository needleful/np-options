class_name SettingsNode
extends Node

const save_path = 'user://settings.cfg'

@export var option_scripts: Array[Script]
var sub_options: Dictionary
var option_scripts_dict : Dictionary

signal ui_redraw

const USAGE_FLAGS = PROPERTY_USAGE_SCRIPT_VARIABLE | PROPERTY_USAGE_EDITOR
var initialized := false

func _enter_tree() -> void:
	sub_options = {}
	for sub_options in get_children():
		add_options(sub_options.get_script(), sub_options)
	for osc in option_scripts:
		var options = osc.new()
		if options is Node:
			add_child(options)
		add_options(osc, options)
	load_settings()

func _exit_tree():
	save_settings()

func add_options(osc: Script, options):
	if osc.has_script_signal('ui_redraw'):
		var res = options.ui_redraw.connect(ui_redraw.emit)
		if res != OK:
			push_error('Could not connect ui_redraw signal!  Error: ', res)
	sub_options[options.group_name] = options
	option_scripts_dict[options.group_name] = osc

func get_options_group(group_name: String):
	return sub_options.get(group_name)

func reset_group(group_name: String):
	pass

func load_settings():
	if !FileAccess.file_exists(save_path):
		push_error('No settings file: ', save_path)
		return
	var file:ConfigFile = ConfigFile.new()
	var res = file.load(save_path)
	if res != OK:
		print_debug('Failed to load save file: ', save_path,
			'\nError code: ', res)
		return
	
	for section in file.get_sections():
		if !(section in sub_options):
			push_warning('Unsupported section found in settings file: ', section)
			continue
		sub_load_from(sub_options[section], file)
	initialized = true

func save_settings():
	var file:ConfigFile = ConfigFile.new()
	for o in sub_options.values():
		file = sub_save_to(o, file)

	var res = file.save(save_path)
	if res != OK:
		push_error('Failed to save config file with error: ',res)

func sub_load_from(options, file: ConfigFile):
	var section_name = options.group_name
	if options.has_method('set_option'):
		for property in file.get_section_keys(section_name):
			options.set_option(property, file.get_value(section_name, property))
	else:
		for property in file.get_section_keys(section_name):
			options.set(property, file.get_value(section_name, property))

func sub_save_to(options, file: ConfigFile):
	var section_name = options.group_name
	for property in options.get_property_list():
		if property.usage & USAGE_FLAGS == USAGE_FLAGS:
			file.set_value(section_name, property.name, options.get(property.name))
	return file
