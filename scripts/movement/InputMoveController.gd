extends AbstractMoveController

class_name InputMoveController

func get_velocity():
	var velocity = Vector2()
	if Input.is_action_pressed("person_right"):
		velocity.x += 1
	if Input.is_action_pressed("person_left"):
		velocity.x -= 1
	if Input.is_action_pressed("person_up"):
		velocity.y -= 1
	if Input.is_action_pressed("person_down"):
		velocity.y += 1
		
	return velocity
