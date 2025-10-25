@tool
extends HSlider

func _enter_tree():
	$TextureRect.texture = get_theme_icon('color_hue', 'ColorPicker')
