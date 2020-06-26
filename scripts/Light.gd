extends Node2D

export var enable: bool = true

signal on_enabled
signal on_disabled

func _ready():
	if enable:
		enable()
	else:
		disable()

func enable():
	if $Animation:
		$Animation.play('on')
	enable = true
	update_light()
	emit_signal("on_enabled")
	
func disable():
	if $Animation:
		$Animation.play('off')
	enable = false
	update_light()
	emit_signal("on_disabled")
	
func update_light():
	$Light.enabled = enable
	if enable:
		$LightArea.enable()
	else:
		$LightArea.disable()

func toggle():
	if !enable:
		enable()
	else:
		disable()


func _on_Animation_ready():
	pass # Replace with function body.
