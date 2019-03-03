extends KinematicBody2D

signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

""" DECRO - SHARED CONSTS & VARS """
const UP = Vector2(0, -1)
const SLOPE_STOP = 5
export var gravity = 1200
export var jump_velocity = -600
export var snapy = 4

export var move_speed = 250

var speed = move_speed
var velocity = Vector2()
var snap = Vector2(0, snapy)
""" DECRO - SHARED CONSTS & VARS """



func _input(event):
		#Quit
	if event.is_action_pressed("ui_quit"):
		get_tree().quit()
		

func take_damage(attacker, amount, effect=null):
	if self.is_a_parent_of(attacker):
		return
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage(amount, effect)

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)
