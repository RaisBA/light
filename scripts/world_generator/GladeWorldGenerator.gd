extends "res://scripts/world_generator/AbstractWorldGenerator.gd"

class_name GladeWorldGenerator

const Glade1 = preload("res://scene/world/glade/glade_1.tscn")
const Glade2 = preload("res://scene/world/glade/glade_2.tscn");
const Glade3 = preload("res://scene/world/glade/glade_3.tscn");
const Border = preload("res://scene/world/glade/glade_border.tscn");

const Boy = preload("res://scene/units/Boy.tscn")
const Skelet = preload("res://scene/units/Skeleton.tscn")
const Fire = preload("res://scene/Fire.tscn")
const ELEMENT_SIZE = 64.0

var empty: Array = [Glade1, Glade2]
var dirty: Array = [Glade3]
var borders: Array = [Border]

var rng := RandomNumberGenerator.new()
func setup(config: GeneratorConfig):
	self.config = config
	rng.set_seed(config.sed)

func generate(navigation: Navigation2D):
	var back = Node2D.new()
	back.name = 'background'
	navigation.add_child(back)
	var empty_positions = []
	
	for i in range(config.world_size.x):
		for j in range(config.world_size.y):
			var is_dirty = (rng.randi() % 10) > 7
			var src_arr: Array = dirty if is_dirty else empty
			var res_id = rng.randi() % src_arr.size()
			var glade = src_arr[res_id].instance()
			
			var real_pos = add_glade(navigation, back, glade, Vector2(i, j))
			if !is_dirty:
				empty_positions.append(real_pos)
	
	add_borders(navigation)
	generate_units(empty_positions, navigation)

func add_glade(navigation: Navigation2D, back: Node2D, glade, pos: Vector2):
	var real_pos = Vector2(to_position(pos.x, config.world_size.x), to_position(pos.y, config.world_size.y))
	glade.set_position(real_pos)
	back.add_child(glade)
	var nav = glade.get_nav()
	nav.set_position(real_pos)
	navigation.add_child(nav)
	return real_pos
	
func to_position(position, size):
	return (position * ELEMENT_SIZE) - (size/2*ELEMENT_SIZE)

func add_borders(navigation: Navigation2D):
	for i in range(-1, config.world_size.y +1 ):
		var brd_left = borders[rng.randi() % borders.size()].instance()
		brd_left.set_position(Vector2(to_position(-1, config.world_size.x), to_position(i, config.world_size.y)))
		navigation.add_child(brd_left)
		
		var brd_right = borders[rng.randi() % borders.size()].instance()
		brd_right.set_position(Vector2(to_position(config.world_size.x, config.world_size.x), to_position(i, config.world_size.y)))
		navigation.add_child(brd_right)

	for i in range(config.world_size.x):
		var brd_left = borders[rng.randi() % borders.size()].instance()
		brd_left.set_position(Vector2(to_position(i, config.world_size.x), to_position(-1, config.world_size.y)))
		navigation.add_child(brd_left)
		
		var brd_right = borders[rng.randi() % borders.size()].instance()
		brd_right.set_position(Vector2(to_position(i, config.world_size.x), to_position(config.world_size.y, config.world_size.y)))
		navigation.add_child(brd_right)

func generate_units(positions: Array, navigation: Navigation2D):
	for i in config.boy:
		var rnd_pos = rng.randi() % (positions.size() - 1)
		var position = positions[rnd_pos]
		var fire = Fire.instance()
		fire.set_position(position)
		
		var boy = Boy.instance()
		boy.set_position(positions[rnd_pos + 1])
		boy.move_center = position
		boy.move_radius = 200
		boy.set_lamp_life_time(rng.randf_range(config.min_lamp_life_time, config.max_lamp_life_time))
		navigation.add_child(fire)
		navigation.add_child(boy)
		positions.remove(rnd_pos)
		positions.remove(rnd_pos + 1)
	GameProperties.boy_count = config.boy
		
	for i in config.skeleton:
		var rnd_pos = rng.randi() % (positions.size() - 1)
		var position = positions[rnd_pos]
		var skelet = Skelet.instance()
		skelet.set_position(positions[rnd_pos])
		skelet.move_center = position
		navigation.add_child(skelet)
		positions.remove(rnd_pos)
		positions.remove(rnd_pos + 1)
	GameProperties.skeleton_count = config.skeleton
