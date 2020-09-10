extends "res://Characters/TemplateCharacter/TemplateCharacter.gd"


const RED = Color('e76767')
const WHITE = Color('ffffff')
const VIEW_RANGE = 20

var Player


func _ready():
	Player = get_node('/root').find_node('Player', true, false)


func _process(delta):
	
	if player_detected():
		$Light2D.color = RED
	else:
		$Light2D.color = WHITE


func player_detected():
	var camera_direction = Vector2(1,0).rotated(global_rotation)
	var player_direction = (Player.position - global_position).normalized()
	
	if abs(player_direction.angle_to(camera_direction)) < deg2rad(VIEW_RANGE):
		return true
	
	return false
