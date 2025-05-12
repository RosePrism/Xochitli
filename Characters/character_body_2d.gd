extends CharacterBody2D

@export var move_speed : float = 100

func _physics_process(_delta):
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	#print(input_direction)
	
	#update velocity
	velocity = input_direction * move_speed
	move_and_slide()
	
	
	
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#wasdw
#func _physics_process(_delta):
	## Add the gravity.
	##if not is_on_floor():
		##velocity += get_gravity() * _delta
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
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	#
	#move_and_slide()
