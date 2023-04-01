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

func _on_MainMenu_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_PlayAgain_mouse_entered():
	$VBoxContainer/PlayAgain.modulate = Color(0.5,0.5,0.5)

func _on_PlayAgain_mouse_exited():
	$VBoxContainer/PlayAgain.modulate = Color(1, 1, 1)
	
func _on_MainMenu_mouse_exited():
	$VBoxContainer/MainMenu.modulate = Color(1, 1, 1)

func _on_MainMenu_mouse_entered():
	$VBoxContainer/MainMenu.modulate = Color(0.5, 0.5, 0.5)
