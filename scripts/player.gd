extends CharacterBody2D

@onready var coyoteTimer = $CoyoteTimer
@onready var rollTimer = $RollTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var coyote_frames = 5
@export var speed = 130.0
@export var jump_velocity = -300.0
@export var max_fall_speed = 300

var coyote = false
var last_floor = false
var jumping = false

var double_jump_available = true
var is_rolling = false
var roll_animation_frames = 5
var roll_animation_fps = 15
 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	coyoteTimer.wait_time = coyote_frames / 60 # 60 fps
	rollTimer.wait_time = roll_animation_frames / roll_animation_fps / 60

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta
	
	# Clamp fall speed
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and can_jump():	
		velocity.y = jump_velocity
		jumping = true
		
		if double_jump_available and !is_on_floor() and !coyote:
			animated_sprite.play("roll")
			double_jump_available = false
			is_rolling = true
		
		if coyote:
			coyote = false
	
	# Stop jump when button is released
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y /= 5
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
	elif !is_rolling:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	# Coyote timer
	if is_on_floor():
		double_jump_available = true
		jumping = false
	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		coyoteTimer.start()
		
	last_floor = is_on_floor()

func can_jump():
	return is_on_floor() or double_jump_available or coyote
	
func _on_coyote_timer_timeout():
	coyote = false

func _on_roll_timer_timeout():
	is_rolling = false
