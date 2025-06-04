extends CharacterBody2D

enum FLAME_STATE { IDLE, AGRO }#if left and right movment i wanted add LEFT and RIGHT states, then coppy what was done with the match
var detection_range = 100

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var move_speed : float = 35

@onready var player_body_2d: CharacterBody2D = $"../CharacterBody2D" # reference to player
var player_transform : Transform2D
var distance_to_player : float 
var direction_to_player : Vector2

var move_direction : Vector2 = Vector2.ZERO
var current_state : FLAME_STATE = FLAME_STATE.IDLE


func _physics_process(_delta):
	player_transform = player_body_2d.transform # grab player's transform
	distance_to_player = (transform.origin.distance_to(player_transform.origin)) # calculate distance from self to player
	direction_to_player = (player_transform.origin - transform.origin).normalized() # calculate the direction to the player
	
	#DEBUG
	print('enemy location: ' + str(transform.origin))
	print('player location: ' + str(player_transform.origin))
	print('direction to player: ' + str(direction_to_player))
	
	match current_state:
		FLAME_STATE.IDLE:
			#walk back and forth code goes here
			move_direction = Vector2(randf()*2 -1, randf()*2 -1) # makes him vibrate as a test (get rid of this line to stop vibrations)
			
			#check if player is within range, if they are then set state to agro
			if (distance_to_player < detection_range):
				current_state = FLAME_STATE.AGRO
				
		FLAME_STATE.AGRO:
			#walk towards player code goes here
			move_direction = direction_to_player
			
			if (distance_to_player > detection_range):
				current_state = FLAME_STATE.IDLE
	
	velocity = move_direction * move_speed
	move_and_slide()
