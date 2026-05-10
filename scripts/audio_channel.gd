extends Resource
class_name AudioChannel

@export var vol: float:
	set(v):
		vol = v
		AudioServer.set_bus_volume_db(index, percent_to_db(vol))
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

func percent_to_db(percent):
	return 50*log(0.99*percent + 0.01)/log(10)

func db_to_percent(db):
	return (pow(10, db/50) - 0.01) /0.99
