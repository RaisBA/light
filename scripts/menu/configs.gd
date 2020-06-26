extends VBoxContainer

func _process(delta):
	print(GeneratorConfig.world_size.x)

func changed(value, property: String):
	var prop = GeneratorConfig
	var names = property.split('.')
	for p in names.size() - 1:
		prop = prop[names[p]]
	print('a' + str(prop[names.size()-1]) + ' v' + str(value))
	prop[names.size()-1] = value
	
func ready_value(object, property: String):
	var prop = GeneratorConfig
	for p in property.split('.'):
		prop = prop[p]
	object.value = prop
