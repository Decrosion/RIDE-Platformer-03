extends "../motion.gd"


func initialize(xxx, xxxx):
	pass

func enter():
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	root.velocity.y = root.jump_velocity
	owner.get_node("AnimatedSprite").play("jump")
	root.snap.y = 0

func update(delta):
	var input_direction = get_input_direction()
	update_look_direction(input_direction)
		
	_update_motion(delta)
	
	if root.velocity.y > 0:
		root.snap.y = root.snapy
		if _on_floor():
			emit_signal("finished", "previous")

