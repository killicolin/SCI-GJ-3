extends Camera2D


onready var p1 = null 
onready var p2 = null

signal zoom_change

func _ready():
	# Initialization here
	set_process(true)
	
func _process(delta):
	var p1_pos = p1.position
	var p2_pos = p2.position
	var newpos = (p1_pos+p2_pos) * 0.5
	self.global_position = newpos
	var distance = p1_pos.distance_to(p2_pos) * 2
	var zoom_factor = distance * 0.002
	var min_zoom = 1
	set_zoom(Vector2(1,1) * max(zoom_factor / 2, min_zoom))
	if self.zoom.x != 1.0 :
		emit_signal("zoom_change")
