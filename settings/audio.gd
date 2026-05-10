extends Object
class_name AudioSettings

@export var master_audio: Resource = AudioChannel.new('Master')
@export var music: Resource = AudioChannel.new('Music')
@export var sfx: Resource = AudioChannel.new('SFX')
@export var voices: Resource = AudioChannel.new('Voice')

var group_name := &'Audio'

func encode(property: String):
	var a: AudioChannel = get(property)
	return str(a.vol) + ';' + str(a.muted)

func decode(property: String, value: String) -> void:
	var p := value.split(';')
	var a: AudioChannel = get(property)
	a.vol = float(p[0])
	a.muted = p[1] == 'true'
