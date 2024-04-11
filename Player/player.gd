extends CharacterBody2D

@export var speed: float = 100
@onready var animation_tree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_fsm = animation_tree["parameters/playback"]
@onready var target = global_position

# offset from player characterbody center to the collision center which is the
# "isometric floor" collision point. Used to offset mouse input location from
# characterbody
@onready var offset = $CollisionShape2D.position

@onready var player_fsm = $Player_FSM

var moving: bool = false
var attacking: bool = false
var dead: bool = false

#var idle_state = load("res://IdleState.gd")

func _ready():
	pass

func _physics_process(delta):
	if animation_fsm.get_current_node() == "End":
		rebirth()
	
func _apply_movement():

	if position.distance_to(target) > 2:
		moving = true
		velocity = position.direction_to(target) * speed
		move_and_slide()
	else:
		moving = false
		stop()
	#avoid sliding against wall forever
	#print(get_real_velocity().length())
	if velocity.length() < 10:
		moving = false
		stop()

	
func attack():
	stop()
	animation_fsm.travel("Attack_E")
	
func die():
	stop()
	animation_fsm.travel("Death")

func rebirth():
	animation_fsm.travel("Start")

func stop():
	velocity = Vector2.ZERO
	target = position
