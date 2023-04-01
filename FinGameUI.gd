extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Singleton.winner == "p1":
		self.get_node("VBoxContainer").get_node("Label").text = "Ressources revendiquées par player 1 !"
	if Singleton.winner == "p2":
		self.get_node("VBoxContainer").get_node("Label").text = "Ressources revendiquées par player 2 !"


func _on_PlayAgain_pressed():
	get_tree().change_scene("res://Level1.tscn")
	pass # Replace with function body.


func _on_MainMenu_pressed():
	get_tree().change_scene("res://Main.tscn")
	pass # Replace with function body.
