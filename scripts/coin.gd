extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var game_manager: Node = $"../../GameManager"

func _on_body_entered(body: Node2D) -> void:
	GameManager.add_point()
	animation_player.play("Pickup")
