extends Button


func _ready():
	connect("button_up", self, "_on_exit_btn_button_up")

func _on_exit_btn_button_up():
	get_tree().quit()
