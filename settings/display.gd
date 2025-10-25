extends Node
class_name DisplaySettings

signal ui_redraw

@export var theme:Theme

enum ScreenMode {
	Fullscreen,
	Windowed,
	Borderless,
	ExclusiveFullscreen
}

#warning-ignore:unused_class_variable
@export var screen_mode: ScreenMode: get = get_screen, set = set_screen
#warning-ignore:unused_class_variable
@export var vsync: bool: get = get_vsync, set = set_vsync
@export_range(8, 120) var text_size: int: get = get_textsize, set = set_textsize
@export var text_color: Color:
	get:
		return theme.get_color('font_color', 'Label')
	set(val):
		theme.set_color('font_color', 'Label', val)
		theme.set_color('font_color', 'Button', val)
		theme.set_color('font_color', 'OptionButton', val)
		theme.set_color('font_color_fg', 'TabBar', val)
		theme.set_color('font_color_fg', 'TabContainer', val)
		theme.set_color('default_color', 'RichTextLabel', val)
		emit_signal('ui_redraw')

var group_name := &'Display'

func set_screen(val: ScreenMode):
	screen_mode = val
	if !get_window():
		return
	match screen_mode:
		ScreenMode.Fullscreen:
			get_window().mode = Window.MODE_FULLSCREEN
			get_window().borderless = false
		ScreenMode.Windowed:
			get_window().mode = Window.MODE_WINDOWED
		ScreenMode.Borderless:
			get_window().mode = Window.MODE_WINDOWED
			get_window().borderless = true
		ScreenMode.ExclusiveFullscreen:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN

func get_screen() -> int:
	return screen_mode

func set_vsync(val: bool):
	vsync = val
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (val) else DisplayServer.VSYNC_DISABLED)

func get_vsync()->bool:
	vsync = (DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)
	return vsync

func get_textsize():
	text_size = theme.default_font_size
	return text_size

func set_textsize(val):
	text_size = val
	theme.default_font_size = val
	emit_signal('ui_redraw')
