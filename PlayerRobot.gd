extends KinematicBody2D

export var speed = 0
export var acceleration = 90
export var decceleration_factor = 3
export var min_speed = 0
export var max_speed = 400
export var gravity = 200

var velocity
var player = "p1"
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
	var input_direction = Vector2(0,0)
	if player == "p1":
		if not robotDisabled:
			input_direction = Input.get_vector("ui_accept", "p1_right", "ui_accept", "ui_accept")
			if input_direction[0] >= 1:
				work()
				robotDrive = true
			else:
				robotDrive = false
				input_direction[0] = 1
		else:
			speed = 0
	
	elif player == "p2":
		if not robotDisabled:
			input_direction = Input.get_vector("ui_accept", "p2_right", "ui_accept", "ui_accept")
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
		
		var awaited_KEY = null
		
		if player == "p1":
			awaited_KEY = p1_choices[rng.randi_range(1, (len(p1_choices)-1))]
		elif player == "p2":
			awaited_KEY = p2_choices[rng.randi_range(1, (len(p2_choices)-1))]
		
#		print("@@@ AWAITED KEY "+str(awaited_KEY))
#		$CanvasLayer/QTE.play(awaited_KEY)

func work():
	if state == "stop" and $turnedOnTimer.time_left == 0 && $AnimatedSprite.animation != "reboot":
		$turnedOnTimer.start()
	elif state == "work" and robotDisabled == false:
		asset_driving_run()
		
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

func QTEKeyPlayed(key):
	print(key)
	print("QTE ENTERED")
	var choices = []
	if player == "p1":
		choices = p1_choices
	elif player == "p2":
		choices == p2_choices
		
	if key == awaited_KEY:
		QTE_state += 1
		if QTE_state == QTE_nb:
			work()
			QTE_nb += 1
			$CanvasLayer/QTE.play("ok")
			return
		awaited_KEY = choices[rng.randi_range(1, (len(choices)-1))]
		$CanvasLayer/QTE.play(awaited_KEY)


func _input(event):
	if event is InputEventKey and event.pressed:
#		if state == "broke":
#			var choices = null
#			QTEKeyPlayed(event)
#			if player == "p1":
#				choices = p1_choices
#			elif player == "p2":
#				choices = p2_choices
#
#			awaited_KEY = choices[rng.randi_range(1, (len(choices)-1))]
		if player == "p1":
			if Input.is_action_pressed("p1_stop"):
				stop()
		elif player == "p2":
			if Input.is_action_pressed("p2_stop"):
				stop()

func _on_disabledTimer_timeout():
	print("End disability")
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
