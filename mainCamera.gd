extends Camera2D

export var dezoom_max = 55

onready var player_nb = 0
onready var player = [] 

var first
signal zoom_change

func _ready():
	# Initialization here
	set_process(true)
	first=true
	
func _process(delta):
	var newpos = Vector2(0,0)
	var i = 0
	for nb in range(0,player_nb):
		#if self.global_position.distance_to(player[nb].position)< dezoom_max || first:
			i+=1
			newpos += player[nb].position
	first = false
	newpos = newpos/ i
	self.global_position = newpos
	var distance = 0
	for nb1 in range(0,player_nb):
		for nb2 in range(0,player_nb):
			distance = max(distance,player[nb1].position.distance_to(player[nb2].position)*2)

	var zoom_factor = distance * 0.002
	var min_zoom = 1
	set_zoom(Vector2(1,1) * max(zoom_factor / 2, min_zoom))
	if self.zoom.x != 1.0 :
		emit_signal("zoom_change")
