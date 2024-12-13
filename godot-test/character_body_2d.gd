extends CharacterBody2D

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

var free = false
var counter = false
var walking = false
	

#Basic Godot physics script I used for testing
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
		#$animations.animation = "run"
		#if direction < 0:
			#$animations.flip_h = true
		#else:
			#$animations.flip_h = false
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#$animations.animation = "idle"
		
# Functions to play any cutscene animation needed
func autorun():
	$animations.animation = "run"
	walking = true
func autostop():
	$animations.animation = "idle"
	walking = false
	
# Button functionality (attack/parry)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("slash") and free:
		$animations.play("attack")
		free = false
	if Input.is_action_just_pressed("parry") and free:
		$animations.play("parry")
		parry()
		free = false

func _process(delta):
	if Engine.get_frames_drawn() % 15 == 0 and walking:
		$footsteps.play()
# Function to set player free/busy whenever from AnimationPlayer and other actions
func set_free(flag):
	free = flag
	
func start_lvl():
	set_free(true)
	
func _on_animations_animation_finished() -> void:
	$animations.play("idle")
	free = true
	
# Functions for player actions

func parry():
	counter = true
	await get_tree().create_timer(0.5).timeout
	counter = false

func attack():
	pass
