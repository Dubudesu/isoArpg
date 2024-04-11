extends Node2D

@export var DEBUG: bool = false

@onready var green_slime = $Room_1/GreenSlime
@onready var room_1: TileMap = $Room_1
@onready var player = $Room_1/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	if DEBUG:
		pass
	pass # Replace with function body.


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DEBUG:
		queue_redraw()

func _draw():
	
	if DEBUG:
		pass
		draw_line(green_slime.position + green_slime.offset, green_slime.home, Color(1,.1,.1), 2)
		draw_line(green_slime.position + green_slime.offset, green_slime.moveTarget, Color(.1,.9,.1), 2)
