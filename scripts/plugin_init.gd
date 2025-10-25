@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type(
		'FastOptionsMenu', 
		'Panel', 
		load('res://addons/fast_options/scripts/options_menu.gd'),
		preload('res://addons/np-options/assets/node_icon.png'))

func _exit_tree():
	remove_custom_type('FastOptionsMenu')
