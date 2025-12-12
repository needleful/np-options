extends Node
class_name GraphicsSettings

signal env_changed

enum Quality {
	High,
	Medium,
	Low,
	Disabled
}

@export var shadow_quality := Quality.Medium: set = set_q_shadows
@export var anti_aliasing := Quality.Medium: set = set_anti_alias
@export var grass_quality := Quality.High:
	set(q):
		grass_quality = q
		match q:
			Quality.High:
				_grass_distance = 300.0
			Quality.Medium:
				_grass_distance = 75.0
			Quality.Low:
				_grass_distance = 20.0
			Quality.Disabled:
				_grass_distance = 0.0
@export var bloom: bool = false:
	set(b):
		bloom = b
		emit_signal('env_changed')

var _grass_distance: float

var group_name := &'Graphics'

func _ready():
	grass_quality = grass_quality

func set_q_shadows(sq):
	shadow_quality = sq
	var directional_shadow_size := 'rendering/lights_and_shadows/directional_shadow/size'
	var shadow_atlas_size := 'rendering/lights_and_shadows/positional_shadow/atlas_size'
	match shadow_quality:
		Quality.High:
			ProjectSettings[directional_shadow_size] = 8192
			ProjectSettings[shadow_atlas_size] = 4096
		Quality.Medium:
			ProjectSettings[directional_shadow_size] = 4096
			ProjectSettings[shadow_atlas_size] = 2048
		Quality.Low, Quality.Disabled:
			ProjectSettings[directional_shadow_size] = 2048
			ProjectSettings[shadow_atlas_size] = 1024
	emit_signal('env_changed')

func set_anti_alias(a: Quality):
	anti_aliasing = a
	var alias_quality := get_viewport().msaa_3d
	match a:
		Quality.High:
			alias_quality = Viewport.MSAA_8X
		Quality.Medium:
			alias_quality = Viewport.MSAA_4X
		Quality.Low:
			alias_quality = Viewport.MSAA_2X
		Quality.Disabled:
			alias_quality = Viewport.MSAA_DISABLED
	get_viewport().msaa_3d = alias_quality
