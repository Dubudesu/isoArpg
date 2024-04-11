extends Area2D


var rng = RandomNumberGenerator.new()
var distance = 20
var jump_speed = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	await get_tree().create_timer(randf_range(.5,3.0)).timeout
	$Timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	slime_jump()
	
func slime_jump():
	rng.randomize()
	var dir = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized() * distance
	
	print("name: ", str(self.get_instance_id()), "jumping to: ", dir )
	
	var tween = create_tween().set_parallel()
	
	tween.tween_property(self, "scale", 
		Vector2(1.2,1.2), jump_speed/2.0 ).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "position", dir, jump_speed).as_relative()
	tween.tween_property(self, "scale", 
		Vector2(1.0,1.0), jump_speed/2.0 ).set_delay(jump_speed/2.0)

	
	


func _on_slime_green_mouse_entered():
	$Sprite2d.get_material().set_shader_parameter("width", 1)
	Mouse.hover(self)

func _on_slime_green_mouse_exited():
	$Sprite2d.get_material().set_shader_parameter("width", 0)
	Mouse.no_hover()
