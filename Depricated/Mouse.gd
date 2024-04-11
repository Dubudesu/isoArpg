extends Node2D

var target_body = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	global_position = get_global_mouse_position()

func hover(body):
	print("Hovering: ", body)
	target_body = body
func no_hover():
	print("Not Hovering!")
	target_body = null
