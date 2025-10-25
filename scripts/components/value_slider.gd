@tool
extends Control

var color := Color.WHITE: set = set_color

func set_color(c: Color):
	color = c
	#TODO: do I need update()?

func _draw():
	var dark := color
	var light := color
	dark.v = 0
	light.v = 1
	var colors:PackedColorArray = [dark, dark, light, light]
	var points:PackedVector2Array = [
		Vector2(0, size.y),
		Vector2(0,0),
		Vector2(size.x, 0), 
		Vector2(size.x, size.y)]
	draw_polygon(points, colors)
