extends AbstractMoveController

class_name RandomMoveController

var navigation: Navigation2D
var target: Node2D
var paths = []

var center: Vector2
var radius: float
var prev_position: Vector2 = Vector2.ZERO
var one_position_count: int = 0

func change_dist(dist: Vector2):
	if dist:
		paths = navigation.get_simple_path(target.position, dist)

var rng = RandomNumberGenerator.new()
func get_velocity():
	var position = target.position
	if paths.size() < 1:
		var new_position = Vector2(center.x + rand_margin(), center.y + rand_margin())
		paths = navigation.get_simple_path(position, new_position)
	else:
		var m = prev_position.direction_to(position)
	
		if m.length() < 0.5:
			one_position_count += 1
		else:
			one_position_count = 0
		if (one_position_count > 10):
			one_position_count = 0
			paths = []
	prev_position = position

	if (paths.size() >= 1):
		var velocity = position.direction_to(paths[0])
		var distance = position.distance_to(paths[0])
		if distance < 1:
			paths.remove(0)
		return velocity
		
	return Vector2(0, 0)

func setup(navigation, target, center, radius):
	rng.randomize()
	self.navigation = navigation
	self.target = target
	self.center = center
	self.radius = radius
	
func rand_margin():
	return rng.randf_range(-1.0, 1.0) * radius
