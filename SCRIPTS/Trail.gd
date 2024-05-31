extends Line2D

@export var maxLength : int
var queue : Array 
var character : CharacterBody2D

func _process(_delta):
	var pos = character.position
	queue.push_front(pos)
	
	if queue.size() > maxLength:
		queue.pop_back()
	clear_points()
	
	for point in queue:
		add_point(point)
