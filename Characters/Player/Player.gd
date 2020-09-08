extends "res://Characters/TemplateCharacter/TemplateCharacter.gd"


# Declare member variables here. Examples:
var motion = Vector2()


func _physics_process(delta):
	# Alweys look at the mouse
	$Sprite.look_at(get_global_mouse_position())
	# updates player coords
	move_player()
	# Moves the body along a vector. If the body collides with another, 
	# it will slide along the other body rather than stop immediately. 
	# If the other body is a KinematicBody2D or RigidBody2D, it will 
	# also be affected by the motion of the other body. You can use this 
	# to make moving or rotating platforms, or to make nodes push other nodes.
	move_and_slide(motion)


func move_left_right():
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)


func move_up_down():
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)


func move_player():
	move_left_right()
	move_up_down()
