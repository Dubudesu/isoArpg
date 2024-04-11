extends TileMap


func _process(delta):
#	var tile = local_to_map(get_global_mouse_position())
#	var itile = cart_to_iso(tile)
#	if Input.is_action_just_pressed("click"):
#		print("Tile: (%d,%d)" % [tile.x,tile.y] )
#		print("Iso??: (%d)" % [itile.x] )
#
#		if Input.is_action_pressed("Attack_In_Place"):
#			erase_cell(1,tile)
	pass

func cart_to_iso(tile):
	return Vector2( tile.x - tile.y, tile.y )
