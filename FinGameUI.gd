extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Singleton.winner == 0:
		self.get_node("VBoxContainer").get_node("Label").text = "Drapeau planté par player 1. Le cratère est à vous !"
	if Singleton.winner == 1:
		self.get_node("VBoxContainer").get_node("Label").text = "Drapeau planté par player 2. Le cratère est à vous !"
	if Singleton.winner == 2:
		self.get_node("VBoxContainer").get_node("Label").text = "Drapeau planté par player 3. Le cratère est à vous !"
	if Singleton.winner == 3:
		self.get_node("VBoxContainer").get_node("Label").text = "Drapeau planté par player 4. Le cratère est à vous !"


func _on_PlayAgain_pressed():
	$bip.play()
	get_tree().change_scene("res://Level2.tscn")

func _on_MainMenu_pressed():
	$bip1.play()
	get_tree().change_scene("res://Main.tscn")

func _on_PlayAgain_mouse_entered():
	$VBoxContainer/PlayAgain.modulate = Color(0.5,0.5,0.5)

func _on_PlayAgain_mouse_exited():
	$VBoxContainer/PlayAgain.modulate = Color(1, 1, 1)
	
func _on_MainMenu_mouse_exited():
	$VBoxContainer/MainMenu.modulate = Color(1, 1, 1)

func _on_MainMenu_mouse_entered():
	$VBoxContainer/MainMenu.modulate = Color(0.5, 0.5, 0.5)
