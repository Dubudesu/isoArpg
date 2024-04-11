extends Node
class_name WanderComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var i = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if owner.wandering:
		if owner.velocity.length() == 0:
			wander()
	pass
	
func wander():
	randomize()
	var angle = 0
	var x = randf_range(-10, 10)
	var y = randf_range(-10, 10)

	var wt: Vector2
	var dist = randf_range(owner.MAXWANDERRANGE/4,owner.MAXWANDERRANGE/2)
	if owner.position.distance_to(owner.home) > owner.MAXWANDERRANGE:
		wt =  owner.position + owner.position.direction_to(owner.home)* dist
	else:
		angle = randf_range(0, PI)
		wt = owner.position - Vector2(x, y).rotated(angle).normalized() * dist
	owner.moveTarget = wt
