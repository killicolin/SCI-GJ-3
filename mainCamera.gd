extends Camera2D

export var dezoom_max = 2
export var dist_max = 800
onready var player_nb = 0
onready var player = []

signal zoom_change

class Sorter:
	func custom_sort(a, b):
		return a.position.x > b.position.x 

func _ready():
	# Initialization here
	set_process(true)
	
func _process(delta):
	
	var player_still_screen = []
	var sorter = Sorter.new()
	var player_sorted=player
	player_sorted.sort_custom(sorter,"custom_sort")
	var newpos = Vector2(0,0)
	var tmp_new_pos = Vector2(0,0)
	var i = 0
	self.global_position = player_sorted[0].position
	tmp_new_pos=self.global_position
	for nb in range(0,player_nb):
		if tmp_new_pos.distance_to(player_sorted[nb].position)< dist_max:
			i+=1
			newpos += player_sorted[nb].position
			tmp_new_pos=newpos/i
			player_still_screen.append(nb)
	newpos = newpos/ i
	self.global_position = newpos
	var distance = 0
	for nb1 in player_still_screen:
		for nb2 in player_still_screen:
			distance = max(distance,player[nb1].position.distance_to(player[nb2].position)*2)

	var zoom_factor = distance * 0.002
	var min_zoom = 1
	if i == player_nb:
		print("YOLO")
		print(max(zoom_factor / 2, min_zoom))
		set_zoom(Vector2(1,1) * max(zoom_factor / 2, min_zoom))
	else :
		print("nOO")
		print(i)
		set_zoom(Vector2(1,1) *dezoom_max)
	if self.zoom.x != 1.0 :

		emit_signal("zoom_change")
