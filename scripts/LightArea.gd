extends Area2D

func _on_Light_body_entered(body):
	if body.has_method("on_light"):
		body.on_light(self)

func disable():
	$coll.disabled = true
	$Blocker/coll.disabled = true
	
func enable():
	$coll.disabled = false
	$Blocker/coll.disabled = false
