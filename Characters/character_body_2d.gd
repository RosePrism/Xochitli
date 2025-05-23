extends CharacterBody2D

@export var move_speed : float = 100
@onready var animated_sprite = $AnimatedSprite2D

enum Direction { LEFT, RIGHT, UP, DOWN}
var last_direction: Direction = Direction.DOWN
 


func _physics_process(_delta):
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	#print(input_direction)
	#NEW ANIMATIONS MUST TAKE PRIORITES OVER THESE IE HIT ANS DASH AND MAGIC
	if (input_direction.x > 0):
		animated_sprite.play("Walk D")
		last_direction = Direction.RIGHT
	elif (input_direction.x < 0):
		animated_sprite.play("Walk A")
		last_direction = Direction.LEFT
	elif (input_direction.y < 0):
		animated_sprite.play("Walk W")
		last_direction = Direction.UP
	elif (input_direction.y > 0):
		animated_sprite.play("Walk S")
		last_direction = Direction.DOWN

	else:
		match (last_direction):
			Direction.LEFT:
				animated_sprite.play("Idle A")
			Direction.RIGHT:
				animated_sprite.play("Idle D")
			Direction.UP:
				animated_sprite.play("Idle W")
			Direction.DOWN:
				animated_sprite.play("Idle S")
	
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
