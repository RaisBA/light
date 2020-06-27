extends GridContainer

var configFile: String = "user://config.json"
var file = ConfigFile.new()

func _ready():
	var file = ConfigFile.new()
	if file.load(configFile) == 0:
		if file.has_section_key("generator", "world_size"):
			GeneratorConfig.world_size = file.get_value("generator", "world_size")
		if file.has_section_key("generator", "sed"):
			GeneratorConfig.sed = file.get_value("generator", "sed")
		if file.has_section_key("generator", "boy"):
			GeneratorConfig.boy = file.get_value("generator", "boy")
		if file.has_section_key("generator", "skeleton"):
			GeneratorConfig.skeleton = file.get_value("generator", "skeleton")

func changed(value, property: String):
	var prop = GeneratorConfig
	var names = property.split('.')
	for p in names.size() - 1:
		prop = prop[names[p]]
	prop.set(names[names.size()-1], value)
	file.set_value("generator", property, value)
	file.save(configFile)
	
func ready_value(object, property: String):
	var prop = GeneratorConfig
	for p in property.split('.'):
		prop = prop[p]
	object.set_value(prop)
	
