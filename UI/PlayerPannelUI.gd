extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal pertubation_on_ui
signal pertubation_off_ui

export var timeBeforeExplosion = 3
export var radiation_duration = 2
export var fake_info_reload = 2

var player = null
var atomics = true
var is_finish_ui = false
var actions= ["p1_action","p2_action","p3_action","p4_action"]
var fakes= ["p1_fake","p2_fake","p3_fake","p4_fake"]
# Called when the node enters the scene tree for the first time.
func _ready():
	set_player_label(player)

func set_player_label(player_number):
	$Label.text="Player " + str(player_number) + " :"

func _input(event):
	if event is InputEventKey and event.pressed:
		for current_player in range(1,3):
			if player == current_player:
				if Input.is_action_pressed(actions[player-1]):
					if atomics:
						atomics = false
						$player_atomics.start()
						$show_atomics_used.start(timeBeforeExplosion)
						yield(get_tree().create_timer(timeBeforeExplosion), "timeout")
						if !is_finish_ui :
							emit_signal("pertubation_on_ui")
							yield(get_tree().create_timer(radiation_duration), "timeout")
							emit_signal("pertubation_off_ui")
						break
				elif Input.is_action_pressed(fakes[player-1]):
					$fake_info_trigger.start(timeBeforeExplosion)
					yield($fake_info_trigger, "timeout")
					break

func player_visual_communiaction():
	var a= 0

func is_finished():
	is_finish_ui = true

func _on_player_atomics_timeout():
	#atomics are ready again
	$Atomics.modulate = Color(1,1,1)
	atomics = true

func _on_show_atomics_used_timeout():
	$Atomics.modulate = Color(0.2,0.2,0.2)
	atomics = false
