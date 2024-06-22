extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 200.0
var dash_counter = 0

func _physics_process(delta):
	velocity = Vector2.ZERO
	var dash_factor = 1
	var play_move = false
	
	if Input.is_action_just_pressed("dash"):
		dash_counter = 5
	
	if dash_counter:
		dash_counter = dash_counter - 1
		dash_factor = 5
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		play_move = true
		animated_sprite_2d.flip_h = false
	if Input.is_action_pressed("move_left"):
		velocity.x += -1
		play_move = true
		animated_sprite_2d.flip_h = true
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		play_move = true
	if Input.is_action_pressed("move_up"):
		velocity.y += -1
		play_move = true
		
	if play_move:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("default")

	if velocity.length() > 0:
		velocity = velocity.normalized() * dash_factor * SPEED
	
	move_and_slide()

# This function is called whenever an input event is detected
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				print("Left mouse button pressed at position: ", event.position)
				on_left_click(event.position)
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				print("Right mouse button pressed at position: ", event.position)
				on_right_click(event.position)

# Function to handle left mouse button click
func on_left_click(position):
	# Add your code to handle the left click here
	print("Left click action at: ", position)
	animated_sprite_2d.play("swipe_sword_down")

# Function to handle right mouse button click
func on_right_click(position):
	# Add your code to handle the right click here
	print("Right click action at: ", position)
