extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var robotScene = load("res://Robot.tscn")
onready var sunScene = load("res://Sun.tscn")
onready var noiseScene = load("res://NoiseEffect.tscn")
onready var UIunit = load("res://UI/PlayerPannelUI.tscn")

onready var noise = noiseScene.instance()
onready var sun = sunScene.instance()
onready var p1 = robotScene.instance()
onready var p2 = robotScene.instance()

var nbPlayers = 2

# Called when the node enters the scene tree for the first time.
func _ready():

	for nb in range(0,nbPlayers):
		var i = UIunit.instance()
		i.player = nb + 1
		$CanvasLayer/UIbar/PanelContainer/HBoxContainer.add_child(i)
		
	p2.player = "p2"
	p1.position = $SpawnPoint.position
	p1.get_node("AnimatedSprite").offset = Vector2(0,-100)
	p1.get_node("AnimatedSprite").modulate = Color(0,0,0.7)
	p2.position = $SpawnPoint.position
	p2.get_node("AnimatedSprite").offset = Vector2(0,-200)
	p2.get_node("AnimatedSprite").z_index = -1
	p2.get_node("AnimatedSprite").modulate = Color(0.7,0,0)
	
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

