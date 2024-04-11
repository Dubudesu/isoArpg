extends Camera2D

const MAXZOOM: float = 1.5
const MINZOOM: float = 3.0
const ZOOM: float = 0.2

func zoom():
	if Input.is_action_just_released('zoom_out'):
		set_zoom(get_zoom() - Vector2(ZOOM, ZOOM))
	if Input.is_action_just_released('zoom_in'): #and get_zoom() > Vector2.ONE:
		set_zoom(get_zoom() + Vector2(ZOOM, ZOOM))
	if get_zoom().x < MAXZOOM:
		set_zoom( Vector2(MAXZOOM,MAXZOOM))
	if get_zoom().x > MINZOOM:
		set_zoom( Vector2(MINZOOM,MINZOOM))
	
func _physics_process(delta):
	zoom()
