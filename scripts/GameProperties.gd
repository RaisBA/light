extends Node

export var game_over := false
var boy_count: int = 0
var skeleton_count: int = 0

func get_boy_count():
	return boy_count
	
func set_boy_count(boy_count: int):
	self.boy_count = boy_count

func get_skeleton_count():
	return skeleton_count
	
func set_skeleton_count(skeleton_count: int):
	self.skeleton_count = skeleton_count

func decrease_boy():
	self.boy_count -= 1

func decrease_skeleton():
	self.skeleton_count -= 1
