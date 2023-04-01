extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PowerIcone.visible=true
	$QTE.visible=false

func set_player_label(player_number):
	$Label.text="Player " + str(player_number) + " :"

func player_is_down():
	$PowerIcone.visible=true
	$QTE.visible=false
	
func player_is_up():
	$PowerIcone.visible=false
	$QTE.visible=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
