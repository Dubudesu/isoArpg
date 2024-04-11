extends CharacterBody2D

var mouse_down = false
var destination = Vector2()
var moving = false

var move_speed = 1000

var attack_range = 10;

enum state {
	idle,
	walking,
	attacking
}
var current_state = state.idle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if Input.is_mouse_button_pressed( 1 ): # Left click
		
		destination = get_global_mouse_position()
		print("Destination: ", destination ," distance: ", position.distance_to(destination) )
		
		#if(Mouse.hover()):
			#state
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_movement(delta)
	
	

func process_movement(delta):
	moving = false if position.distance_to(destination) < 2 else true

	if moving == false:
		velocity = Vector2.ZERO
		$AnimationPlayer.play("Idle")
		current_state = state.idle
	else:
		$AnimationPlayer.play("walk")
		current_state = state.walking
		velocity = position.direction_to(destination) * move_speed * delta
	move_and_slide()
	
	
func attack():
	print("attack!")
	#$AnimationPlayer.play("attack_default")

