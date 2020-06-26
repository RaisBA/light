extends Navigation2D

export (String) var border = "res://scene/world/glade/glade_border.tscn"
export (PoolStringArray) var childe = ["res://scene/world/glade/glade_1.tscn"]
export (Vector2) var world_size = Vector2(10, 10)
export (float) var element_size = 64.0
var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()
	var res = []
	for i in childe.size():
		res.append(load(childe[i]))
	
	for i in range(world_size.x):
		for j in range(world_size.y):
			var res_id = rng.randi() % res.size()
			var glade = res[res_id].instance()
			glade.set_position(Vector2(to_position(i, world_size.x), to_position(j, world_size.y)))
			$background.add_child(glade)
			var nav = glade.get_nav()
			nav.set_position(Vector2(to_position(i, world_size.x), to_position(j, world_size.y)))
			add_child(nav)
	
	add_borders()

func to_position(position, size):
	return (position * element_size) - (size/2*element_size)

func add_borders():
	var brd = load(border)
	for i in range(-1, world_size.y +1 ):
		var brd_left = brd.instance()
		brd_left.set_position(Vector2(to_position(-1, world_size.x), to_position(i, world_size.y)))
		add_child(brd_left)
		
		var brd_right = brd.instance()
		brd_right.set_position(Vector2(to_position(world_size.x, world_size.x), to_position(i, world_size.y)))
		add_child(brd_right)

	for i in range(world_size.x):
		var brd_left = brd.instance()
		brd_left.set_position(Vector2(to_position(i, world_size.x), to_position(-1, world_size.y)))
		add_child(brd_left)
		
		var brd_right = brd.instance()
		brd_right.set_position(Vector2(to_position(i, world_size.x), to_position(world_size.y, world_size.y)))
		add_child(brd_right)
