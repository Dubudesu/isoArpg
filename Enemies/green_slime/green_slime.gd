extends CharacterBody2D

@export var SPEED: float = 50.0
@export var MAXWANDERRANGE: int = 100

var moving: bool = false
@onready var moveTarget: Vector2 = position
@onready var offset: Vector2 = $CollisionShape2D.position

@onready var home: Vector2 = self.global_position


var chasing: bool = false
var scared: bool = false
var wander_timer: Timer = null

func _ready():
	wander_timer = Timer.new()
	add_child(wander_timer)
	wander_timer.timeout.connect(wander)
	wander_timer.set_wait_time(3.0)
	wander_timer.set_one_shot(false) # Make sure it loops

func _physics_process(delta):
	pass
	
func move(delta):
	velocity = position.direction_to(moveTarget) * SPEED
	if position.distance_to(moveTarget) > 3:
		moving = true
		move_and_slide()
	else:
		stop()
		moving = false
	if velocity.length() < 10:
		moving = false
		stop()

func flee():
	print("Time to flee!")
	stop()
	scared = true
	moveTarget = home

func idle():
	scared = false
	stop()
	wander_timer.start()
	
func stop():
	velocity = Vector2.ZERO
	moveTarget = position

func wander():
	randomize()
	var angle = 0
	var x = randf_range(-10, 10)
	var y = randf_range(-10, 10)

	var wt: Vector2
	var dist = randf_range(MAXWANDERRANGE/4, MAXWANDERRANGE/2)
	if  position.distance_to(home) >  MAXWANDERRANGE:
		wt = position + position.direction_to(home)* dist
	else:
		angle = randf_range(0, PI)
		wt = owner.position - Vector2(x, y).rotated(angle).normalized() * dist
	moveTarget = wt
