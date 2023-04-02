extends KinematicBody2D

export var speed = 0
export var acceleration = 90
export var decceleration_factor = 3
export var min_speed = 0
export var max_speed = 400
export var gravity = 300

var velocity
var player
var state = "work"

var robotDisabled = false
var robotDrive = false
var robotTurnOff = false

var floor_normal = Vector2.UP

var informationOrderReady = true
var exp_speed=1
var atomics = true

var QTE_nb = 5
var QTE_state = 0
var awaited_KEY = null
var color_emit = [Color(0,0,0.7),Color(0.7,0,0),Color(0.7,0.7,0),Color(0,0.7,0)]

var p1_choices = ["p1_left", "p1_right", "p1_up", "p1_down"]
var p2_choices = ["p2_left", "p2_right", "p2_up", "p2_down"]

var right_actions = ["p1_right","p2_right","p3_right","p4_right"]
var stop_actions = ["p1_stop","p2_stop","p3_stop","p4_stop"]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

#func ready():
#	if player == "p1":
#		$AnimatedSprite.z_index = 10
#		$AnimatedSprite.offset = Vector2(0, 0)
#	if player == "p2":
#		$AnimatedSprite.z_index = -10
#		$AnimatedSprite.offset = Vector2(0, -500)

func get_input():
	print(player)
	var input_direction = Vector2(0,0)
	if not robotDisabled:
		input_direction = Input.get_vector("ui_accept", right_actions[player], "ui_accept", "ui_accept")
		if input_direction[0] >= 1:
			work()
			robotDrive = true
		else:
			robotDrive = false
			input_direction[0] = 1
	else:
		speed = 0
	
	velocity = input_direction * speed

func acceleration(delta):
	if (speed < max_speed): #  IF speed not max speed --> accelerate
		#speed += delta * acceleration
		exp_speed= min(exp_speed+delta*acceleration,log(max_speed))
		speed = exp(exp_speed)
		if (speed > max_speed): # IF speed > max speed --> speed = max speed
			speed = max_speed

func decceleration(delta):
	if (speed > min_speed): #  IF speed not max speed --> accelerate
		#speed -= delta * acceleration * decceleration_factor 
		exp_speed= max(exp_speed-delta*acceleration,1)
		speed = exp(exp_speed)
		if (speed < min_speed): # IF speed > max speed --> speed = max speed
			speed = min_speed


func _physics_process(delta):
	get_input()
	#check_state()
	move_and_slide(velocity)
#	if is_on_floor():
	
	
	if not robotDisabled:
		if robotDrive and state == "work":
			acceleration(delta)
		else:
			decceleration(delta)
	

	
#	print(player, " \t state: ", state)
	position.y -= delta * gravity * -1
	$debugLabel.text = self.state


#func check_state():
#	if state == "broke":
#		self.modulate = Color(0.7,0,0)
#	elif state == "work":
#		self.modulate = Color(0,0.7,0)
#	elif state == "stop":
#		self.modulate = Color(0,0,0.7)

func asset_broke_run():
	$AnimatedSprite.play("broke")
	$ExplodeSound.play(0.0)

func asset_reboot_run():
	$AnimatedSprite.play("reboot")
	$PowerUpSound.play(0.0)

func asset_driving_run():
	$AnimatedSprite.play("work")
	if !$DrivingSound.playing :
		$DrivingSound.play(0.0)
	
func asset_stop_run():
	$AnimatedSprite.play("stop")
	$PowerDownSound.play(0.0)
	if $DrivingSound.playing :
		$DrivingSound.stop()
	
func broke():
	if state == "work":
		state = "broke"
		robotDisabled = true
		$disabledTimer.start()
		asset_broke_run()
		$zapSprite.play("zap")
		var awaited_KEY = null
		
#		if player == "p1":
#			awaited_KEY = p1_choices[rng.randi_range(1, (len(p1_choices)-1))]
#		elif player == "p2":
#			awaited_KEY = p2_choices[rng.randi_range(1, (len(p2_choices)-1))]
		
#		print("@@@ AWAITED KEY "+str(awaited_KEY))
#		$CanvasLayer/QTE.play(awaited_KEY)

func work():
	if state == "stop" and $turnedOnTimer.time_left == 0 && $AnimatedSprite.animation != "reboot":
		$turnedOnTimer.start()
	elif state == "work" and robotDisabled == false:
		asset_driving_run()
		$zapSprite.play("ok")
		
func stop():
	if state == "work":
		state = "stop"
		yield(get_tree().create_timer(1.0), "timeout")
		asset_stop_run()

func repair():
	if state == "disabled":
		asset_reboot_run()
		yield(get_tree().create_timer(1.0), "timeout")
		state = "work"

func _input(event):
	if event is InputEventKey and event.pressed:
		if Input.is_action_pressed(stop_actions[player]):
			stop()

func _on_disabledTimer_timeout():
	$zapSprite.play("ok")
	state = "stop"
	robotDisabled = false

func _on_turnedOnTimer_timeout():
	print("Rover turn on. Go!")
	asset_reboot_run()

func reception_is_emit(player_index):
	if $AnimReception.playing :
		$AnimReception.stop()
		$AnimReception.frame=0
	$AnimReception.modulate=color_emit[player_index]
	$AnimReception.play()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "reboot":
		state = "work"
		asset_driving_run()
