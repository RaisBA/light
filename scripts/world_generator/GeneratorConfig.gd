extends Node

const WorldType: Array = [
	'glade'
]
export var world_size: Vector2 = Vector2(20, 20)
export var sed: int = 12314
export var world_type = 'glade'
export var boy: int = 10
export var skeleton: int = 10
export var max_lamp_life_time: float = 30
export var min_lamp_life_time: float = 10

var rng := RandomNumberGenerator.new()
func _init():
	rng.randomize()
	sed = rng.randf() * 10000.0
