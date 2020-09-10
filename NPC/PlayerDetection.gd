extends "res://Characters/TemplateCharacter/TemplateCharacter.gd"

const RED = Color('e76767')
const WHITE = Color('ffffff')
const VIEW_RANGE = 20
const VIEW_DISTANCE = 600

var Player


func _ready():
	# find player object
	Player = get_node('/root').find_node('Player', true, false)


func _process(delta):
	if player_in_view_range() and player_in_view_distance():
		if not $AudioAlarm.playing:
			$AudioAlarm.play()
		$Light2D.color = RED
	else:
		$Light2D.color = WHITE
		$AudioAlarm.playing = false


func player_in_view_range():
	"check if the player inside the view range +- 20 degrees"
	
	var camera_direction = Vector2(1,0).rotated(global_rotation)
	var player_direction = (Player.global_position - global_position).normalized()
	
	if abs(player_direction.angle_to(camera_direction)) < deg2rad(VIEW_RANGE):
		return true
	return false

	
func player_in_view_distance():
	"""check if user in direct view:
	1. not blocked by othe object
	2. distance between camera and the player < VIEW_DISTANCE
	"""
	var game_space = get_world_2d().direct_space_state
	var collided_obj = game_space.intersect_ray(global_position, 
												Player.global_position, 
												[self], 
												collision_mask)
	
	var distance_to_player = Player.global_position.distance_to(global_position)
	
	if not collided_obj:
		return false
	
	if collided_obj.collider == Player and distance_to_player < VIEW_DISTANCE:
		return true
	
	return false
