extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var burst_delta_time =500.0
var null_;
var burst_time;
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.visible=false
	burst_time = OS.get_ticks_msec()+burst_delta_time
	print_debug($TextureRect.material.get_shader_param("filter"))
#	#$TextureRect.visible=false # Replace with function body.

func is_on_perturbating():
	$RadAudio.play(0.0)
	burst_time = OS.get_ticks_msec()+burst_delta_time
	$TextureRect.visible=true
	$TextureRect.material.set_shader_param("filter",0.2)

func is_off_perturbating():
	$RadAudio.stop()
	$TextureRect.visible=false

func _physics_process(delta):
	if $TextureRect.visible :
		var current_time = OS.get_ticks_msec()
		var ratio = abs(burst_time-current_time)/burst_delta_time
		if ratio < 1.0 :
#			print_debug(ratio)
			$TextureRect.material.set_shader_param("filter",0.2*ratio)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
