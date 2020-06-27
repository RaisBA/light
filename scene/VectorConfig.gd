extends ValueEdit

export var value: Vector2 = Vector2(0.0, 0.0)

func set_value(value):
	self.value = value
	$HBoxContainer/X.value = value.x
	$HBoxContainer2/Y.value = value.y


func _on_X_value_changed(value):
	self.value.x = value
	on_value_changed(self.value)

func _on_Y_value_changed(value):
	self.value.y = value
	on_value_changed(self.value)
