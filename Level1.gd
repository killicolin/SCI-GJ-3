extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var robotScene = load("res://Robot.tscn")
onready var sunScene = load("res://Sun.tscn")
onready var noiseScene = load("res://NoiseEffect.tscn")

onready var noise = noiseScene.instance()
onready var sun = sunScene.instance()
onready var p1 = robotScene.instance()
onready var p2 = robotScene.instance()

# Called when the node enters the scene tree for the first time.
func _ready():

	p2.player = "p2"
	p1.position = $SpawnPoint.position
	p2.position = $SpawnPoint.position
	p2.get_node("AnimatedSprite").offset = Vector2(0,-50)
	
	add_child(p1)
	add_child(p2)

	$mainCamera.p1 = p1 
	$mainCamera.p2 = p2
	
	sun.connect("pertubation_on", self, "_on_perturbation_received")
	sun.connect("pertubation_off", self, "_on_perturbation_stopped")
	
	sun.connect("pertubation_on", noise, "is_on_perturbating")
	sun.connect("pertubation_off", noise, "is_off_perturbating")
	
	noise.rect_size = Vector2(1920, 1080)
	
	$CanvasLayer.add_child(sun)
	$CanvasLayer.add_child(noise)

func _on_perturbation_received():
	print("PERTURBATION IS ON")
	p1.broke()
	p2.broke()

func _on_perturbation_stopped():
	print("PERTURBATION IS OFF")
	

func _on_endingArea_body_entered(body):
	if body is KinematicBody2D:
		get_tree().change_scene("res://FinGameUI.tscn")

