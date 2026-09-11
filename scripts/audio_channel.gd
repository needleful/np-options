extends Resource
class_name AudioChannel

@export var vol: float = 1.0:
	set(v):
		vol = v
		AudioServer.set_bus_volume_db(index, linear_to_db(vol))
@export var muted: bool:
	set(m):
		muted = m
		AudioServer.set_bus_mute(index, muted)
@export var bus_name: String

var index: int

func _init(name: String = ''):
	resource_name = 'AudioChannel'
	bus_name = name
	index = AudioServer.get_bus_index(bus_name)

func reset():
	vol = 1.0
	muted = false
