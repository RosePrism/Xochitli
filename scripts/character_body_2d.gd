extends CharacterBody2D

var health = 100
var is_invincible = false
@export var move_speed : float = 45 #speed
@onready var animated_sprite = $AnimatedSprite2D
@onready var player_particles: GPUParticles2D = $PlayerParticles

enum Direction { LEFT, RIGHT, UP, DOWN, SHIFT}
var last_direction: Direction = Direction.DOWN
var last_direction_vector: Vector2 = Vector2.DOWN
 
var hat_equipped : bool = false # start no hat

func hit(damage: int) -> void:#health work in progress
	if is_invincible == true:
		return
	health -= damage
	print("Ouch! Health is now:", health)#DEBUG
	

var is_dashing = false
var dash_tween: Tween

func dash(direction: Vector2, delta):#dash work in progress//fixing animation
	if is_dashing:
		return  # prevent overlapping dashes
		
	const dash_distance = 35
	var dash_duration = 0.2
	var my_location = transform.origin
	var destination = my_location + direction*dash_distance
	#transform.origin = destination
	emit_particles()
	
	var tween := create_tween()
	await tween.tween_property(self, "global_position", destination, dash_duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT).finished
	is_dashing = false

func emit_particles():
	#player_particles.direction = Vector2.LEFT
	player_particles.restart()

func _process(delta):#to also be for attacks
	if Input.is_action_just_pressed("attack"):
		attempt_attack()

func attempt_attack():#to be for attacks
	var enemies
	for enemy in enemies:
		if enemy.has_method("hit"):
			enemy.hit(10)  # Deal 10 damage
	
func _physics_process(_delta):
	#get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	#print(input_direction)
	#NEW ANIMATIONS MUST TAKE PRIORITES OVER THESE IE HIT ANS DASH AND MAGIC
	if Input.is_action_just_pressed("dash"):
		if input_direction.length() < 0.1:
			dash(last_direction_vector, _delta)
		else:
			dash(input_direction, _delta)
		#animated_sprite.play("Dash")
		#last_direction = Direction.SHIFT
	elif !hat_equipped:#char picked up hat
		if (input_direction.x > 0):
			animated_sprite.play("Walk D")
			last_direction = Direction.RIGHT
			last_direction_vector = Vector2.RIGHT
		elif (input_direction.x < 0):
			animated_sprite.play("Walk A")
			last_direction = Direction.LEFT
			last_direction_vector = Vector2.LEFT
		elif (input_direction.y < 0):
			animated_sprite.play("Walk W")
			last_direction = Direction.UP
			last_direction_vector = Vector2.UP
		elif (input_direction.y > 0):
			animated_sprite.play("Walk S")
			last_direction = Direction.DOWN
			last_direction_vector = Vector2.DOWN
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
	else:#yet to find hat
		if (input_direction.x > 0):
			animated_sprite.play("Walk DH")
			last_direction = Direction.RIGHT
			last_direction_vector = Vector2.RIGHT
		elif (input_direction.x < 0):
			animated_sprite.play("Walk AH")
			last_direction = Direction.LEFT
			last_direction_vector = Vector2.LEFT
		elif (input_direction.y < 0):
			animated_sprite.play("Walk WH")
			last_direction = Direction.UP
			last_direction_vector = Vector2.UP
		elif (input_direction.y > 0):
			animated_sprite.play("Walk SH")
			last_direction = Direction.DOWN
			last_direction_vector = Vector2.DOWN
		else:
			match (last_direction):
				Direction.LEFT:
					animated_sprite.play("Idle AH")
				Direction.RIGHT:
					animated_sprite.play("Idle DH")
				Direction.UP:
					animated_sprite.play("Idle WH")
				Direction.DOWN:
					animated_sprite.play("Idle SH")

	#update velocity
	velocity = input_direction * move_speed
	move_and_slide()
	
#const SPEED = 300.0#og given code for movment, good for side scroller
#const JUMP_VELOCITY = -400.0
#
#w
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
	
#func equip_hat():#maybe this for at idk yet// not in use, save for backup
	#var new_frames = preload("res://Sprites/PlayerWithHat.tres")
	#animated_sprite.sprite_frames = new_frames
	#animated_sprite.play("idle")

func equip_hat():
	print("Equipping hat!")
	hat_equipped = true
