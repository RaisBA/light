extends "res://scripts/action/Action.gd"

class_name KillAction

func do_action(target, event):
	if target.has_method("die"):
		target.die()


func fire_on_add():
	return true
	

func one_time():
	return true
