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

var informationOrderReady = true

var atomics = true

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
		speed += delta * acceleration
		
		if (speed > max_speed): # IF speed > max speed --> speed = max speed
			speed = max_speed

func decceleration(delta):
	if (speed > min_speed): #  IF speed not max speed --> accelerate
		speed -= delta * acceleration * decceleration_factor 
		
		if (speed < min_speed): # IF speed > max speed --> speed = max speed
			speed = min_speed


func _physics_process(delta):
	get_input()
	#check_state()
	move_and_slide(velocity)
	
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
#	$DrivingSound.play(0.0)
	
func asset_stop_run():
	$AnimatedSprite.play("stop")
	$PowerDownSound.play(0.0)
	
func broke():
	if state == "work":
		state = "broke"
		robotDisabled = true
		$disabledTimer.start()
		asset_broke_run()


func work():
	if state == "stop" and $turnedOffTimer.time_left == 0:
		$turnedOffTimer.start()
		asset_reboot_run()
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

func _input(event):
	if event is InputEventKey and event.pressed:
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

func _on_turnedOffTimer_timeout():
	print("Rover turn on. Go!")
	state = "work"
