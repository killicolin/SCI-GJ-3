extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_emit = 0
signal pertubation_on_ui
signal pertubation_off_ui
signal send_reception(player_emit)

export var timeBeforeExplosion = 3
export var radiation_duration = 2
export var fake_info_reload_time = 10

var player_instance
var player = null
var atomics = true
var fake_available = true
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
		if player_instance.state == "work" :
			for current_player in range(1,3):
				if player == current_player:
					if Input.is_action_pressed(actions[player-1]):
						if atomics:
							atomics = false
							$player_atomics.start()
							$show_atomics_used.start(timeBeforeExplosion)
							emit_signal("send_reception",player-1)
							yield(get_tree().create_timer(timeBeforeExplosion), "timeout")
							if !is_finish_ui :
								emit_signal("pertubation_on_ui")
								yield(get_tree().create_timer(radiation_duration), "timeout")
								emit_signal("pertubation_off_ui")
							break
					elif Input.is_action_pressed(fakes[player-1]):
						
						if fake_available :
							fake_available = false
							emit_signal("send_reception",player-1)
							$fake_info_trigger.start(timeBeforeExplosion)
							$fake_info_reload.start(fake_info_reload_time)
						break

func _on_fake_info_trigger_timeout():
	var a = 0
	$Fakes.modulate = Color(0.2,0.2,0.2)

func _on_fake_info_reload_timeout():
	$Fakes.modulate = Color(1,1,1)
	fake_available = true

func is_finished():
	is_finish_ui = true

func _on_player_atomics_timeout():
	#atomics are ready again
	$Atomics.modulate = Color(1,1,1)
	atomics = true

func _on_show_atomics_used_timeout():
	$Atomics.modulate = Color(0.2,0.2,0.2)
	atomics = false
