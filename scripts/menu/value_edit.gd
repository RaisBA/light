extends Range

export var property: String

func _ready():
	get_tree().call_group('config', 'ready_value', self, property)
	connect("value_changed", self, "on_value_changed")

func on_value_changed(value):
	get_tree().call_group('config', 'changed', value, property)
