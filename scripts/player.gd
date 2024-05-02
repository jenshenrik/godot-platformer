extends CharacterBody2D


@onready var coyoteTimer = $CoyoteTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var coyote_frames = 5
@export var SPEED = 130.0
@export var JUMP_VELOCITY = -300.0

var coyote = false
var last_floor = false
var jumping = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")



func _ready():
	coyoteTimer.wait_time = coyote_frames / 60 # 60 fps

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		if (coyote):
			print("jumped, coyote spent")
		else:
			print("jumped, not coyote")
			
		velocity.y = JUMP_VELOCITY
		jumping = true
		coyote = false

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Coyote timer
	if is_on_floor():
		jumping = false
	if !is_on_floor() and last_floor and !jumping:
		print("starting coyote timer, " + str(last_floor))
		coyote = true
		coyoteTimer.start()
		
	last_floor = is_on_floor()

func _on_coyote_timer_timeout():
	print("coyote timer ended")
	coyote = false
