extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var selectPlayersScene = preload("res://SelectPlayers.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Play_pressed():
	var s = selectPlayersScene.instance()
	$VBoxContainer/Play.queue_free()
	$VBoxContainer.add_child(s)
	$click.play()

func _on_Play_mouse_entered():
	$VBoxContainer/Play.modulate = Color(0.5,0.5,0.5)


func _on_Play_mouse_exited():
	$VBoxContainer/Play.modulate = Color(1,1,1)


func _on_Exit_pressed():
	$click_bis.play()
	get_tree().quit()



func _on_Exit_mouse_entered():
	$VBoxContainer/Exit.modulate = Color(0.5,0.5,0.5)

func _on_Exit_mouse_exited():
	$VBoxContainer/Exit.modulate = Color(1,1,1)
