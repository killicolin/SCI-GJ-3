extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	set_player_label(player)

func set_player_label(player_number):
	$Label.text="Player " + str(player_number) + " :"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
