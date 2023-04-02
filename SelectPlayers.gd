extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_2_pressed():
	Singleton.playerNb = 2
	$bip.play()
	get_tree().change_scene("res://Level2.tscn")


func _on_3_pressed():
	Singleton.playerNb = 3
	$bip.play()
	
	get_tree().change_scene("res://Level2.tscn")


func _on_4_pressed():
	Singleton.playerNb = 4
	$bip.play()
	
	get_tree().change_scene("res://Level2.tscn")

func _on_2_mouse_entered():
	$HBoxContainer/VBoxContainer.get_node("2").modulate = Color(0.5,0.5,0.5)

func _on_2_mouse_exited():
	$HBoxContainer/VBoxContainer.get_node("2").modulate = Color(1,1,1)
	

func _on_3_mouse_entered():
	$HBoxContainer/VBoxContainer.get_node("3").modulate = Color(0.5,0.5,0.5)
	

func _on_3_mouse_exited():
	$HBoxContainer/VBoxContainer.get_node("3").modulate = Color(1,1,1)
	

func _on_4_mouse_entered():
	$HBoxContainer/VBoxContainer.get_node("4").modulate = Color(0.5,0.5,0.5)
	

func _on_4_mouse_exited():
	$HBoxContainer/VBoxContainer.get_node("4").modulate = Color(1,1,1)
	

#func _on_Play_mouse_entered():
#	$VBoxContainer/Play.modulate = Color(0.5,0.5,0.5)
#
#
#func _on_Play_mouse_exited():
#	$VBoxContainer/Play.modulate = Color(1,1,1)
