extends "res://scripts/action/Action.gd"

class_name KillByClickAction

func do_action(target, event):
	if target.has_method("die"):
		target.die()


func one_time():
	return true
