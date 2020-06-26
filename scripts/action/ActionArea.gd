extends Area2D

func _on_ActionArea_body_entered(body):
	if body.has_method("add_action"):
		body.add_action(self.get_parent())

func _on_ActionArea_body_exited(body):
	if self.get_parent() && body.has_method("remove_action"):
		body.remove_action(self.get_parent())

func disable():
	$CollisionShape2D.disabled = true
	
	
func enable():
	$CollisionShape2D.disabled = false
