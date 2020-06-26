extends "res://scripts/action/Action.gd"

class_name DisableAction

var events: Array = []

func setup(events: Array):
	self.events = events
	
func do_action(target, event):
	if events.has(event) && target.has_method("disable"):
		target.disable()

func one_time():
	return true
