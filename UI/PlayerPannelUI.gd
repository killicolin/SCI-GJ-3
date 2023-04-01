extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal pertubation_on
signal pertubation_off

export var timeBeforeExplosion = 3

var player = null
var atomics = true
# Called when the node enters the scene tree for the first time.
func _ready():
	set_player_label(player)

func set_player_label(player_number):
	$Label.text="Player " + str(player_number) + " :"

func _input(event):
	if event is InputEventKey and event.pressed:
		if player == 1:
			if Input.is_action_pressed("p1_action"):
				if atomics:
					print("p1 acted detetcted in UI")
					atomics = false
					$player_atomics.start()
					yield(get_tree().create_timer(timeBeforeExplosion), "timeout")
					emit_signal("pertubation_on")
					$show_atomics_used.start()
		elif player == 2:
			if Input.is_action_pressed("p2_action"):
				if atomics:
					print("p2 acted")
					atomics = false
					$player_atomics.start()
					yield(get_tree().create_timer(timeBeforeExplosion), "timeout")
					emit_signal("pertubation_on")
					$show_atomics_used.start()


func _on_player_atomics_timeout():
	#atomics are ready again
	$Atomics.modulate = Color(1,1,1)
	atomics = true

func _on_show_atomics_used_timeout():
	$Atomics.modulate = Color(0.2,0.2,0.2)
	atomics = false
