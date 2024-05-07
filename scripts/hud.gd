extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var pause_label: Label = $PauseCanvas/PauseLabel

func _ready():
	pause_label.visible = false

func update_score(score):
	score_label.text = str(score)

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game():
	pause_label.visible = true
	get_tree().paused = true
