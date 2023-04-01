extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = null
var atomics = true
# Called when the node enters the scene tree for the first time.
func _ready():
	set_player_label(player)

func set_player_label(player_number):
	$Label.text="Player " + str(player_number) + " :"


func _input(event):
	if event is InputEventKey and event.pressed:
		if player == "p1":
			if Input.is_action_pressed("p1_action"):
				print("p1 acted")
		elif player == "p2":
			if Input.is_action_pressed("p2_action"):
				print("p2 acted")



func _on_player_atomics_used():
	$Atomics.modulate = Color(0.2,0.2,0.2)
	atomics = false

func _on_player_atomics_timeout():
	#atomics are ready again
	$Atomics.modulate = Color(1,1,1)
	atomics = true
	
