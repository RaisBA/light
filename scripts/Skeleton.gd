extends KinematicBody2D

export (int) var speed = 200
export var move_center: Vector2 = Vector2.ZERO
export var move_radius: float = 100.0
export var is_move: bool = true

var velocity = Vector2()
var move_controller
var idle_delay: float = 0.0
var target: Node
var actions: ActionCollector
var die := false

func _ready():
	move_controller = RandomMoveController.new()
	move_controller.setup(get_parent(), self, move_center, move_radius)
	play()
		
	actions = ActionCollector.new()
	var killAction = KillAction.new()
	actions.add_action('boy', killAction)

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
		


func _on_FeelingsArea_body_entered(body: Node2D):
	if body.is_in_group('boy') && !target:
		target = body
		move_controller.change_dist(target.position)


func _on_FeelingsArea_body_exited(body):
	if body == target:
		target = null
		move_controller.change_dist(null)

func add_action(target):
	actions.add_target(target)
	
func remove_action(target):
	actions.remove_target(target)
	
func die():
	if die:
		return
	die = true
	set_physics_process(false)
	$Animation.play('die')
	remove($CollisionShape2D)
	remove($FeelingsArea)
	$ActionArea.disable()
	remove($ActionArea)
	GameProperties.skeleton_count -= 1
	
func remove(child: Node):
	remove_child(child)
	child.queue_free()
