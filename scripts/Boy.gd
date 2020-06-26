extends KinematicBody2D

export (int) var speed = 200
export var move_center: Vector2 = Vector2.ZERO
export var move_radius: float = 100.0
export var is_move: bool = true

var velocity = Vector2()
var move_controller
var idle_delay: float = 0.0
var actions: ActionCollector
var die := false

func _ready():
	
	move_controller = RandomMoveController.new()
	move_controller.setup(get_parent(), self, move_center, move_radius)
	
	actions = ActionCollector.new()
	var disable_action = DisableAction.new()
	disable_action.setup(['lamp_out'])
	actions.add_action('lamp', disable_action)
	
	var get_fire_action = GetFireAction.new()
	get_fire_action.setup($lamp)
	actions.add_action('fire', get_fire_action)
	
	play()

func _physics_process(delta):
	if is_move && idle_delay <= 0:
		velocity = move_controller.get_velocity()

	play()
	
	velocity = velocity.normalized() * speed
	if velocity.length() < 1 && idle_delay <= 0:
		idle_delay = 1.0
	elif idle_delay > 0:
		idle_delay = idle_delay - delta
	velocity = move_and_slide(velocity)

func play():
	if (velocity.length() == 0):
		$Animation.play("idle")
	elif (velocity.y > 0):
		$Animation.play("down")
	elif (velocity.y < 0):
		$Animation.play("up")
	elif (velocity.x > 0):
		$Animation.play("right")
	elif (velocity.x < 0):
		$Animation.play("left")
		
func add_action(target):
	actions.add_target(target)
	
func remove_action(target):
	actions.remove_target(target)
	
func _on_Timer_timeout():
	actions.add_target($lamp)
	actions.do_action('lamp_out')

func set_lamp_life_time(lifeTime: float):
	$Timer.wait_time = lifeTime


func _on_lamp_on_disabled():
	idle_delay = 0
	move_controller.change_dist(move_center)
	
func die():
	if die:
		return
	die = true
	set_physics_process(false)
	$Animation.play('die')
	remove($lamp)
	remove($CollisionShape2D)
	remove($Timer)
	$ActionArea.disable()
	remove($ActionArea)
	GameProperties.boy_count -= 1
	
func remove(child: Node):
	remove_child(child)
	child.queue_free()
