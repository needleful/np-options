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
@export var bloom: bool = false:
	set(b):
		bloom = b
		emit_signal('env_changed')

var group_name := &'Graphics'

func set_q_shadows(sq):
	shadow_quality = sq
	match shadow_quality:
		Quality.High: 
			ProjectSettings['rendering/quality/directional_shadow/size'] = 8192
			ProjectSettings['rendering/lights_and_shadows/shadow_atlas/size'] = 4096
			ProjectSettings['rendering/quality/shadows/filter_mode'] = 1
		Quality.Medium:
			ProjectSettings['rendering/quality/directional_shadow/size'] = 4096
			ProjectSettings['rendering/lights_and_shadows/shadow_atlas/size'] = 2048
			ProjectSettings['rendering/quality/shadows/filter_mode'] = 1
		Quality.Low, Quality.Disabled:
			ProjectSettings['rendering/quality/directional_shadow/size'] = 2048
			ProjectSettings['rendering/lights_and_shadows/shadow_atlas/size'] = 1024
			ProjectSettings['rendering/quality/shadows/filter_mode'] = 0
	emit_signal('env_changed')

func set_anti_alias(a: Quality):
	anti_aliasing = a
	var alias_quality := RenderingServer.VIEWPORT_MSAA_DISABLED
	match a:
		Quality.High:
			alias_quality = RenderingServer.VIEWPORT_MSAA_8X
		Quality.Medium:
			alias_quality = RenderingServer.VIEWPORT_MSAA_4X
		Quality.Low:
			alias_quality = RenderingServer.VIEWPORT_MSAA_2X
		Quality.Disabled:
			alias_quality = RenderingServer.VIEWPORT_MSAA_DISABLED
	RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(), alias_quality)
