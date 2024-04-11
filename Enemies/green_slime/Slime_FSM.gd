extends StateMachine

@onready var anim: AnimationPlayer = owner.get_node("AnimationPlayer")

func _ready():
	_add_states("idle")
	_add_states("chase")
	_add_states("gohome")
	_add_states("attack")
	_add_states("dead")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	owner.move(delta)
	match state:
		states.gohome:
			owner.moveTarget = owner.home
	pass
	
func _get_transition(delta):
	match state:
		states.idle:
			if owner.chasing:
				return states.chase
		states.chase:
			if !owner.chasing:
				return states.idle
			if owner.position.distance_to(owner.home) > owner.MAXWANDERRANGE*3:
				return states.gohome
		states.gohome:
			if owner.position.distance_to(owner.home) < owner.MAXWANDERRANGE:
				return states.idle
	pass

func _enter_state(new_state, old_state):
	match state:
		states.idle:
			owner.get_node("StateLabel").text = states.idle
			anim.play("idle")
			owner.idle()
		states.chase:
			owner.get_node("StateLabel").text = states.chase
			anim.set_speed_scale(3.0)
			anim.play("idle")
		states.gohome:
			owner.get_node("StateLabel").text = states.gohome
			#owner.scared = true
			owner.flee()
		states.attack:
			owner.get_node("StateLabel").text = states.attack
		states.dead:
			owner.get_node("StateLabel").text = states.dead
	pass
func _exit_state(old_state, new_state):
	match old_state:
		states.chase:
			anim.set_speed_scale(1.0)
		states.gohome:
			print("wheeew")
			#owner.scared = false
	pass
