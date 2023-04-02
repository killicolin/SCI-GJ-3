extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_2_pressed():
	Singleton.playerNb = 2
	get_tree().change_scene("res://Level2.tscn")


func _on_3_pressed():
	Singleton.playerNb = 3
	get_tree().change_scene("res://Level2.tscn")


func _on_4_pressed():
	Singleton.playerNb = 4
	get_tree().change_scene("res://Level2.tscn")
