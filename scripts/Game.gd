extends Node2D
const AbstractWorldGenerator = preload("res://scripts/world_generator/AbstractWorldGenerator.gd")

var navigation: Navigation2D

func _init():
	if GeneratorConfig.world_type == 'glade':
		var generator:AbstractWorldGenerator  = load("res://scripts/world_generator/GladeWorldGenerator.gd").new()
		generator.setup(GeneratorConfig)
		navigation = Navigation2D.new()
		navigation.set_name('Navigation')
		generator.generate(navigation)
	GameProperties.game_over = false
	
func _ready():
	$world.add_child(navigation)

func _process(delta):
	if GameProperties.boy_count < 1:
		GameProperties.game_over = true
		$UI/Menu.game_over('All the boys are dead')
	elif GameProperties.skeleton_count < 1:
		GameProperties.game_over = true
		$UI/Menu.game_over('All the skeletons are dead')

