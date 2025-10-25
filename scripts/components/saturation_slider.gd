@tool
extends Control

var color := Color.WHITE: set = set_color

func set_color(c: Color):
	color = c
	# TODO: do I need an equivalent of update()?

func _draw():
	var desat := color
	var hisat := color
	desat.s = 0
	hisat.s = 1
	var colors:PackedColorArray = [desat, desat, hisat, hisat]
	var points:PackedVector2Array = [
		Vector2(0, size.y),
		Vector2(0,0),
		Vector2(size.x, 0), 
		Vector2(size.x, size.y)]
	draw_polygon(points, colors)
