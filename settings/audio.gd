extends Object
class_name AudioSettings

@export var master_audio: Resource = AudioChannel.new('Master')
@export var music: Resource = AudioChannel.new('Music')
@export var sfx: Resource = AudioChannel.new('SFX')

var group_name := &'Audio'

func set_option(property, value):
	get(property).apply(value)
