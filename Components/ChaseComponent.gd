extends Area2D
class_name ChaseComponent

@onready var collision_shape = $CollisionShape2D
@export var detectRange: int = 100

var target: CharacterBody2D = null
var inrange: bool = false
var tpos: Vector2 = Vector2.ZERO

func _ready():
	collision_shape.scale.y = 0.5 #isometric view!
	collision_shape.shape.radius = detectRange
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_chase() and !owner.scared:
		owner.chasing = true
		owner.moveTarget = target.position + target.offset
	else:
		owner.chasing = false
	if inrange:
		queue_redraw()

func can_chase() -> bool:
	if inrange:
		if line_of_sight(target):
			return true
		else:
			return false
	else:
		return false
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		target = body
		print("Player in range!")
		inrange = true
func _on_body_exited(body):
	if body.is_in_group("player"):
		target = null
		print("Player lost!")
		inrange = false

func line_of_sight(body):
	if !body: return false
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(
			to_global(owner.position + owner.offset) ,to_global(body.position + body.offset),
			owner.collision_mask, [owner])
	tpos = body.position + body.offset
	var result = space_state.intersect_ray(query)
	print(result)
	if result == { }:
		return true
	else:
		return false


func _draw():

	draw_line( to_local(owner.position + owner.offset), to_local(tpos), Color(.8,.1,.6), 2)

