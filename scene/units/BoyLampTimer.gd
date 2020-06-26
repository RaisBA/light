extends Timer


func _on_lamp_on_disabled():
	stop()
	
func _on_lamp_on_enabled():
	start(wait_time)
