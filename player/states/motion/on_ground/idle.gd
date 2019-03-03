extends "on_ground.gd"


func enter():
	#$AnimatedSprite.play("idle")
	#owner.get_node("AnimationPlayer").play("idle")
	#get_node("Player/AnimatedSprite").play("idle")
	owner.get_node("AnimatedSprite").play("idle")

func handle_input(event):
	return .handle_input(event)

func update(delta):
	_update_motion(delta)
	var input_direction = get_input_direction()
	if input_direction:
		#owner.velocity.x = lerp(owner.velocity.x, owner.move_speed * input_direction.x, 0.5)
		emit_signal("finished", "move")
	