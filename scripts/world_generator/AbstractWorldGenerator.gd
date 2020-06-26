extends Object

class_name AbstractWorldGenerator
const GeneratorConifg = preload("res://scripts/world_generator/GeneratorConfig.gd")
var config: GeneratorConfig

func setup(config: GeneratorConfig):
	self.config = config

func generate(navigation: Navigation2D):
	pass
