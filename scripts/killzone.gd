extends Area2D

@onready var timer: Timer = $Timer
@onready var game_manager = %GameManager
#@onready var game_manager: Node = $"../../GameManager"

func _on_body_entered(body: Node2D) -> void:
	game_manager.game_over()
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1.0
