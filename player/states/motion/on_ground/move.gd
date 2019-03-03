extends "on_ground.gd"

export(float) var MAX_WALK_SPEED = 450
export(float) var MAX_RUN_SPEED = 700





func enter():
	#speed = 0.0
	#velocity = Vector2()
	

	var input_direction = get_input_direction()
	update_look_direction(input_direction)
	#owner.get_node("AnimationPlayer").play("walk")
	owner.get_node("AnimatedSprite").play("run")
	

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	update_look_direction(input_direction)
	"""GDQ 
	speed = MAX_RUN_SPEED if Input.is_action_pressed("run") else MAX_WALK_SPEED
	var collision_info = move(speed, input_direction)
	if not collision_info:
		return
	if speed == MAX_RUN_SPEED and collision_info.collider.is_in_group("environment"):
		return null
	"""
	#owner.velocity.x = lerp(owner.velocity.x, owner.move_speed * owner.move_direction, _get_h_weight())
	#root.velocity = owner.move_and_slide_with_snap(root.velocity, root.snap, root.UP)
	#root.velocity.x = lerp(root.velocity.x, root.speed * input_direction.x, 0.5)
	_update_motion(delta)
	owner.get_node("AnimatedSprite").flip_h = max(0,(0-root.velocity.x))
	
	
func move(speed, direction):
	root.velocity = direction.normalized() * speed
	#owner.move_and_slide(velocity, Vector2(), 5, 2)
	root.velocity = owner.move_and_slide_with_snap(root.velocity, root.snap, root.UP)
	if root.get_slide_count() == 0:
		return
	return root.get_slide_collision(0)
