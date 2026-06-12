extends Object
class_name AudioSettings

@export var master_audio := AudioChannel.new('Master')
@export var music := AudioChannel.new('Music')
@export var sfx := AudioChannel.new('SFX')

var group_name := &'Audio'

func _reset():
	master_audio.reset()
	music.reset()
	sfx.reset()

func encode(property: String):
	var a: AudioChannel = get(property)
	return str(a.vol) + ';' + str(a.muted)

func decode(property: String, value: String) -> void:
	var p := value.split(';')
	var a: AudioChannel = get(property)
	a.vol = float(p[0])
	a.muted = p[1] == 'true'
