extends "res://NPC/PlayerDetection.gd"

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")

export var treshold = 5

var path


func _ready():
	get_random_path()


func _physics_process(delta):
	navigate()


func get_random_path():
	randomize()
	var destinations_array = destinations.get_children()
	var random_destination = destinations_array[randi() % destinations_array.size() - 1]
	path = navigation.get_simple_path(position, random_destination.position, false)


func navigate():
	if position.distance_to(path[0]) > treshold:
		move()
	else:
		update_path()


func move():
	var next_position = (path[0] - position).normalized() * SPEED
	
	look_at(path[0])
	
	if is_on_wall():
		get_random_path()
	
	move_and_slide(next_position)


func update_path():
	if path.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		path.remove(0)


func _on_Timer_timeout():
	get_random_path()
