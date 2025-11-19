extends HBoxContainer

signal changed(opt_name, value)

var option_name:String

@onready var preview := $Preview

var internal_color: Vector3

func _ready():
	$value/hue.value_changed.connect(_on_hue_value_changed)
	$value/sat.value_changed.connect(_on_sat_value_changed)
	$value/val.value_changed.connect(_on_val_value_changed)

func set_option_hint(option:Dictionary):
	option_name = option.name
	$name.text = option_name.capitalize()

func set_option_value(val:Color):
	internal_color = Vector3(val.h, val.s, val.v)
	preview.color = val
	$value/hue.value = val.h
	$value/sat.value = val.s
	$value/val.value = val.v

func _on_color_changed():
	var i := internal_color
	preview.color = Color.from_hsv(i.x, i.y, i.z)
	$value/sat/preview.color = Color.from_hsv(i.x, 1.0, i.z)
	$value/val/preview.color = Color.from_hsv(i.x, i.y, 1.0)
	emit_signal('changed', option_name, preview.color)

func _on_hue_value_changed(h: float):
	internal_color.x = h
	_on_color_changed()

func _on_sat_value_changed(s:float):
	internal_color.y = s
	_on_color_changed()

func _on_val_value_changed(v:float):
	internal_color.z = v
	_on_color_changed()
