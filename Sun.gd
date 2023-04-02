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
var is_finish = false
var choose_time =0;
var rng = RandomNumberGenerator.new()
var perturbation_time = [time_small_perturbation_on_moon,time_medium_perturbation_on_moon,time_big_perturbation_on_moon]
func _ready():
	is_finish = false
	$SunTrigger.connect("animation_finished", self, "reset_anim")
	$AnimatedSprite.playing = true
	$Between.set_one_shot(true)
	$Between.connect("timeout", self, "choose_perturbation")
	$OnMoon.set_one_shot(true)
	$OnMoon.connect("timeout", self, "emit_on")
	$Perturbating.set_one_shot(true)
	$Perturbating.connect("timeout", self, "emit_off")
	#determinate_next_perturbation()

func is_finished():
	is_finish=true

func reset_anim():
	$SunTrigger.playing = false
	$SunTrigger.frame=0
	determinate_arriving_on_moon()

func emit_on():
	if !is_finish :
		emit_signal("pertubation_on")
		$SunExplosionAudio.stop()
		$Perturbating.start(choose_time)
		print("signal on")

func emit_off():
	emit_signal("pertubation_off")
	determinate_next_perturbation()
	print("signal off")
	
	
func solar_perturbation():
	$SunTrigger.playing = true
	$SunExplosionAudio.play(0.0)


func determinate_arriving_on_moon():
	var my_random_time_to_wait = rng.randf_range(time_arriving_on_moon_min, time_arriving_on_moon_max)
	$OnMoon.start(my_random_time_to_wait)
	
func determinate_next_perturbation():
	var my_random_time_to_wait = rng.randf_range(time_between_perturbation_min, time_between_perturbation_max)
	$Between.start(my_random_time_to_wait)

func choose_perturbation():
	var perturbation_index = rng.randi_range(0,2)
	choose_time=perturbation_time[perturbation_index]
	solar_perturbation()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_Timer_timeout():
#	print_debug("Is_Time_Out")
