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
				get_window().mode = Window.MODE_MAXIMIZED
				get_window().borderless = false
			ScreenMode.BorderlessWindowed:
				get_window().mode = Window.MODE_WINDOWED
				get_window().borderless = true
			ScreenMode.ExclusiveFullscreen:
				get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN

@export var vsync: bool:
	set(val):
		vsync = val
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (val) else DisplayServer.VSYNC_DISABLED)
@export_range(30, 60) var text_size: int = 45:
	set(val):
		text_size = val
		theme.default_font_size = val
		ui_redraw.emit()

var group_name := &'Display'

func _reset():
	screen_mode = ScreenMode.Fullscreen
	vsync = true
	text_size = 45

func option_is_hidden(opt_name: StringName) -> bool:
	return opt_name == &'theme'
