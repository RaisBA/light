extends Button

func _ready():
	connect("button_up", self, "_on_play_btn_button_up")

func _on_play_btn_button_up():
	Main.goto_scene("res://scene/Game.tscn")
