extends Node
class_name DisplaySettings

signal ui_redraw

@export var theme:Theme

enum ScreenMode {
	Fullscreen,
	Windowed,
	BorderlessWindowed,
	ExclusiveFullscreen
}

@export var screen_mode: ScreenMode:
	set(val):
		screen_mode = val
		if !get_window():
			return
		match screen_mode:
			ScreenMode.Fullscreen:
				get_window().mode = Window.MODE_FULLSCREEN
			ScreenMode.Windowed:
				get_window().mode = Window.MODE_WINDOWED
				get_window().borderless = false
			ScreenMode.BorderlessWindowed:
				get_window().mode = Window.MODE_WINDOWED
				get_window().borderless = true
			ScreenMode.ExclusiveFullscreen:
				get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN

#warning-ignore:unused_class_variable
@export var vsync: bool:
	set(val):
		vsync = val
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (val) else DisplayServer.VSYNC_DISABLED)
@export_range(8, 120) var text_size: int = 32:
	set(val):
		text_size = val
		theme.default_font_size = val
		emit_signal('ui_redraw')
@export var text_color: Color = Color.WHITE:
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
