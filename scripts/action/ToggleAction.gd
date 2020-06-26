extends "res://scripts/action/Action.gd"

class_name ToggleAction

func do_action(target, event):
	if target.has_method("toggle"):
		target.toggle()
