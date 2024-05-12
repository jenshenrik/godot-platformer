extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton

func _ready():
	play_button.grab_focus()
	GameManager.hud.hide()

func _on_play_button_pressed() -> void:
	GameManager.start_game()
	

func _on_quit_button_pressed() -> void:
	get_tree().quit()
