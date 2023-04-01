extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal pertubation_on
signal pertubation_off
# GD parameter
export var time_between_perturbation_min = 2.0
export var time_between_perturbation_max = 3.0

export var time_arriving_on_moon_min = 2.0
export var time_arriving_on_moon_max = 3.0

export var time_small_perturbation_on_moon = 2.0
export var time_medium_perturbation_on_moon = 3.0
export var time_big_perturbation_on_moon = 4.0

# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
var perturbation = ["small_solar_perturbation","medium_solar_perturbation","big_solar_perturbation"]
func _ready():
	print_debug("Start")
	$Timer.set_one_shot(true)
	$Timer.connect("timeout", self, "choose_perturbation")
	determinate_next_perturbation()

func emit_on():
	emit_signal("pertubation_on")
	print("signal on")

func emit_off():
	emit_signal("pertubation_off")
	print("signal off")
	

func small_solar_perturbation():
	#print_debug("is_arrive")
	#play animation
	$AnimatedSprite.playing = true
	var time_to_wait = Timer.new()
	determinate_arriving_on_moon(time_to_wait)
	#set state perturbating
	time_to_wait.connect("timeout", self, "emit_on")
	var time_perturbating = Timer.new()
	time_perturbating.set_one_shot(true)
	time_perturbating.set_wait_time(time_small_perturbation_on_moon)
	#unset state perturbating
	time_perturbating.connect("timeout", self, "emit_off")
	self.add_child(time_perturbating)
	time_perturbating.start()
	
	determinate_next_perturbation()

func medium_solar_perturbation():
	#print_debug("is_arrive")
	#play animation
	$AnimatedSprite.playing = true
	var time_to_wait = Timer.new()
	determinate_arriving_on_moon(time_to_wait)
	#set state perturbating
	time_to_wait.connect("timeout", self, "emit_on")
	
	var time_perturbating = Timer.new()
	time_perturbating.set_one_shot(true)
	time_perturbating.set_wait_time(time_medium_perturbation_on_moon)
	#unset state perturbating
	time_perturbating.connect("timeout", self, "emit_off")
	self.add_child(time_perturbating)
	
	time_perturbating.start()
	
	determinate_next_perturbation()

func big_solar_perturbation():
	#print_debug("is_arrive")
	#play animation
	$AnimatedSprite.playing = true
	var time_to_wait = Timer.new()
	determinate_arriving_on_moon(time_to_wait)
	#set state perturbating
	time_to_wait.connect("timeout", self, "emit_on")
	var time_perturbating = Timer.new()	
	time_perturbating.set_one_shot(true)
	time_perturbating.set_wait_time(time_big_perturbation_on_moon)
	#unset state perturbating
	time_perturbating.connect("timeout", self, "emit_off")
	self.add_child(time_perturbating)
	
	time_perturbating.start()
	determinate_next_perturbation()

func determinate_arriving_on_moon(time_to_wait):
	#print_debug("Arriving")
	var my_random_time_to_wait = rng.randf_range(time_arriving_on_moon_min, time_arriving_on_moon_max)
	time_to_wait.set_one_shot(true)
	time_to_wait.set_wait_time(my_random_time_to_wait)
	self.add_child(time_to_wait)
	time_to_wait.start()
	
func determinate_next_perturbation():
	var my_random_time_to_wait = rng.randf_range(time_between_perturbation_min, time_between_perturbation_max)
	$Timer.start(my_random_time_to_wait)


func choose_perturbation():
	var perturbation_index = rng.randi_range(0,3)
	if perturbation_index == 0 :
		small_solar_perturbation()
	elif perturbation_index == 1 :
		medium_solar_perturbation()
	else :
		big_solar_perturbation()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Timer_timeout():
#	print_debug("Is_Time_Out")
