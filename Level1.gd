extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var robotScene = load("res://Robot.tscn")


onready var p1 = robotScene.instance()
onready var p2 = robotScene.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	
 
	
	p2.player = "p2"
	p1.position = $SpawnPoint.position
	p2.position = $SpawnPoint.position
	
	add_child(p1)
	add_child(p2)

	$mainCamera.p1 = p1 
	$mainCamera.p2 = p2


func _on_endingArea_body_entered(body):
	if body is KinematicBody2D:
		get_tree().change_scene("res://FinGameUI.tscn")

