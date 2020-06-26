extends "res://scripts/action/Action.gd"

class_name GetFireAction

var lamp

func setup(lamp):
	self.lamp = lamp
	
func do_action(target, event):
	if target.enable:
		lamp.enable()

func one_time():
	return true
	
func fire_on_add():
	return true
