# Collection of important methods to handle direction and animation
extends "../state.gd"

var input_direction

"""DECRO"""
onready var root = get_node("/root/SceneRoot/PlayerV2")
onready var ray = get_node("/root/SceneRoot/PlayerV2/RayCast2D")


func handle_input(event):
	if event.is_action_pressed("simulate_damage"):
		emit_signal("finished", "stagger")

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction

func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
	if not direction.x in [-1, 1]:
		return
	owner.get_node("BodyPivot").set_scale(Vector2(direction.x, 1))

func _update_motion(delta) :
	input_direction = get_input_direction()
	root.velocity.x = lerp(root.velocity.x, root.speed * input_direction.x, 0.5)
	#if !root.is_on_floor():
	if !_on_floor():
		root.velocity.y += root.gravity * delta
	
	#root.velocity = root.move_and_slide_with_snap(root.velocity, root.snap, root.UP)
	root.velocity = root.move_and_slide(root.velocity, root.UP)

func _on_floor():
	ray.force_raycast_update()
	print(ray.is_colliding())
	return ray.is_colliding() && root.is_on_floor()
