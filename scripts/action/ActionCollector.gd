extends Object
class_name ActionCollector

const Action = preload("res://scripts/action/Action.gd")
var actions: Dictionary = {}

func add_action(group: String, action: Action):
	actions[group] = {'targets': [], 'action': action}

func add_target(target: Node):
	for g in actions.keys():
		if target.is_in_group(g):
			var action = actions[g]
			if action['action'].fire_on_add():
				action['action'].do_action(target, 'add')
				if !action['action'].one_time():
					action['targets'].append(target)
			else:
				action['targets'].append(target)

func remove_target(target: Node):
	for g in actions.keys():
		if target.is_in_group(g):
			var action = actions[g]
			if !action['action'].one_time():
				var targets = action['targets']
				var position = targets.find(target)
				if position >= 0:
					targets.remove(position)

func do_action(event):
	for v in actions.values():
		var to_remove = []
		for i in v['targets'].size():
			v['action'].do_action(v['targets'][i], event)
			if v['action'].one_time():
				to_remove.append(i)
		for i in to_remove:
			v['targets'].remove(i)
