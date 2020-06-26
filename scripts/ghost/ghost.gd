extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
var move_controller
var actions: ActionCollector
var untouchable: float

func _ready():
	move_controller = InputMoveController.new()
	actions = ActionCollector.new()
	actions.add_action('light', ToggleAction.new())
	actions.add_action('skeleton', KillByClickAction.new())
	play()

func _physics_process(delta):
	check_action()
	velocity = move_controller.get_velocity()
	
	touch(delta)
	play()
		
	velocity = velocity.normalized() * speed * delta
	var col = move_and_collide(velocity)

func play():
	if (velocity.length() == 0):
		$Animation.play("boo")
	elif (velocity.y > 0):
		$Animation.play("down")
	elif (velocity.y < 0):
		$Animation.play("up")
	elif (velocity.x > 0):
		$Animation.play("right")
	elif (velocity.x < 0):
		$Animation.play("left")
		
func touch(delta):
	if untouchable >= 0:
		untouchable -= delta
		if !$Oh.visible:
			$Oh.visible = true
	if untouchable <= 0 && $Oh.visible:
		$Oh.visible = false
	
func on_light(from):
	if untouchable <= 0 && randf() < 0.5:
		untouchable += 1

func check_action():
	if Input.is_action_just_pressed("action"):
		actions.do_action('main')

func add_action(target):
	actions.add_target(target)
	
func remove_action(target):
	actions.remove_target(target)
	
