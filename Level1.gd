extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var sun_default_scale =0.4

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
		i.connect("pertubation_on_ui", self, "_on_perturbation_received")
		i.connect("pertubation_on_ui", noise, "is_on_perturbating")
		
		i.connect("pertubation_off_ui", self, "_on_perturbation_stopped")
		i.connect("pertubation_off_ui", noise, "is_off_perturbating")
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

	$mainCamera.add_child(sun)
	get_tree().get_root().connect("size_changed", self, "replace_sun")
	print_debug($mainCamera.get_viewport().get_visible_rect().size.y)
	$mainCamera.connect("zoom_change", self, "replace_sun")
	replace_sun()
	$CanvasLayer.add_child(noise)
	
	
func replace_sun():
	var sun_size =$mainCamera.get_viewport().get_visible_rect().size.y/600
	sun.scale = (Vector2(1.0,1.0)+$mainCamera.zoom*sun_size)*sun_default_scale
	
	var map_pos = Vector2()
	map_pos.x = 0
	map_pos.y =  (-400 - $mainCamera.get_viewport().get_visible_rect().size.y/2)*$mainCamera.zoom.y/2
	sun.position = map_pos

func _on_perturbation_received():
	print("PERTURBATION IS ON")
	p1.broke()
	p2.broke()

func _on_perturbation_stopped():
	print("PERTURBATION IS OFF")
	

func plant_flag():
	$PlantFlag.play(0.0)
	
func _on_endingArea_body_entered(body):
	if body is KinematicBody2D:
		for nb in range(0,nbPlayers):
			var i = UIunit.instance()
			i.is_finished()
		sun.is_finished()
		body.get_node('WinSound').play(0.0)
		body.get_node('AnimatedSprite').play("win")
		body.get_node('DrivingSound').stop()
		body.get_node('AnimatedSprite').connect("animation_finished", self, "plant_flag")
		body.robotDisabled = true
		yield(get_tree().create_timer(4.0), "timeout")
		Singleton.winner = body.player
		get_tree().change_scene("res://FinGameUI.tscn")

