extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_1_pressed():
	Singleton.playerNb = 1
	get_tree().change_scene("res://Level2.tscn")


func _on_2_pressed():
	Singleton.playerNb = 2
	get_tree().change_scene("res://Level2.tscn")


func _on_3_pressed():
	Singleton.playerNb = 3
	get_tree().change_scene("res://Level2.tscn")


func _on_4_pressed():
	Singleton.playerNb = 4
	get_tree().change_scene("res://Level2.tscn")
