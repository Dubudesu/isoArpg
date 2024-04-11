extends StateMachine

func _ready():
	_add_states("idle")
	_add_states("run")
	_add_states("attack")
	_add_states("dead")
	_add_states("rebirth")
	call_deferred("set_state", states.idle)
	pass

func _input(event):
	if ![states.dead, states.attack].has(state):
		
			#Check for valid target in range or attack in place key
		if Input.is_action_pressed("Attack_In_Place"):
			if Input.is_action_pressed("Attack"):
				owner.attacking = true
			else:
				owner.attacking = false
		if Input.is_mouse_button_pressed( MOUSE_BUTTON_LEFT ): # Left click
			
			owner.target = owner.get_global_mouse_position() - owner.offset
			var p = owner.position.direction_to(owner.target)
			#Set blend tree values
			owner.animation_tree.set("parameters/Run/blend_position", p)
			owner.animation_tree.set("parameters/Idle/blend_position", p)

	if Input.is_action_just_pressed("Kill"):
		owner.dead = true

func _state_logic(delta):
	owner._apply_movement()
	
	pass
	
func _get_transition(delta):
	#death gets priority obvi
	match state:
		states.dead:
			if owner.animation_fsm.get_current_node() == "End":
				return states.rebirth
		states.rebirth:
			return states.idle
		states.idle:
			if owner.moving:
				return states.run
			if owner.attacking:
				return states.attack
			if owner.animation_fsm.get_current_node() == "Attack_E":
				return states.attack
			if owner.dead:
				return states.dead
		states.run:
			if !owner.moving:
				return states.idle
			if owner.attacking:
				return states.attack
			if owner.animation_fsm.get_current_node() == "Attack_E":
				return states.attack
			if owner.dead:
				return states.dead
		states.attack:
			if owner.dead:
				return states.dead
			if !owner.animation_fsm.get_current_node() == "Attack_E":
				return states.idle
			
	return null

func _enter_state(new_state, old_state):
	print( " --> " + new_state)
	match states[new_state]:
		states.dead:
			owner.animation_fsm.next() #kills attack animation if dead
			owner.dead = true
			owner.die()
		states.rebirth:
			owner.rebirth()
		states.attack:
			owner.attacking = true
			owner.attack()
		states.idle:
			owner.animation_fsm.travel("Idle")
		states.run:
			owner.animation_fsm.travel("Run")
	return null

func _exit_state(old_state, new_state):

	match states[old_state]:
		states.dead:
			owner.dead = false
			pass
		states.rebirth:
			pass
		states.idle:
			pass
		states.run:
			pass
		states.attack:
			if !Input.is_action_pressed("Attack"):
				owner.attacking = false
			pass
	return null

	pass
