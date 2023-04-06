extends Camera2D
#
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

func reposBackground():
	var ref1 = $"../ParallaxBackground/ParallaxLayer/Sprite"
	var ref2 = $"../ParallaxBackground/ParallaxLayer2/Sprite"
	var ref3 = $"../ParallaxBackground/ParallaxLayer3/Sprite"
	
	ref1.offset.y = self.position.y
	ref2.offset.y = self.position.y
	ref3.offset.y = self.position.y
	
	pass

func _process(delta):
	reposBackground()
	
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
	
	var tween = get_node("Tween")
	tween.interpolate_property(self, "global_position",
			self.global_position, newpos, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	var distance = 0
	for nb1 in player_still_screen:
		for nb2 in player_still_screen:
			distance = max(distance,player[nb1].position.distance_to(player[nb2].position)*2)

	var zoom_factor = distance * 0.002
	var min_zoom = 1
	
	var newZoom = 1
	
	if i == player_nb:
		newZoom = Vector2(1,1) * max(zoom_factor / 2, min_zoom)
	else :
		newZoom = Vector2(1,1) *dezoom_max

	var tween2 = get_node("Tween")
	tween2.interpolate_property(self, "zoom",
			zoom, newZoom, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween2.start()
	
	if self.zoom.x != 1.0 :
		emit_signal("zoom_change")
