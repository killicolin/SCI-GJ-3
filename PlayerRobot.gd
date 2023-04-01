extends KinematicBody2D

export var speed = 10
export var acceleration = 90
export var max_speed = 400
export var gravity = 200

var velocity
var player = "p1"
var state = "stop"

var robotDisabled = false

var debugCounter = 0

var informationOrderReady = true

func ready():
	if player == "p2":
		$AnimatedSprite.z_index = -1
		$AnimatedSprite.offset = Vector2(0, -500)

func get_input():
	var input_direction = Vector2(0,0)
	if player == "p1":
		if not robotDisabled:
			input_direction = Input.get_vector("ui_accept", "p1_right", "ui_accept", "ui_accept")
			if input_direction[0] >= 1:
				work()
			elif state == "stop":
				speed = 10
		else:
			speed = 0
	
	elif player == "p2":
		if not robotDisabled:
			input_direction = Input.get_vector("ui_accept", "p2_right", "ui_accept", "ui_accept")
			if input_direction[0] >= 1:
				work()
			elif state == "stop":
				speed = 10
		else:
			speed = 0
		
	velocity = input_direction * speed

func starting_acceleration(delta, velocity):
	if (speed < max_speed): #  IF speed not max speed --> accelerate
		speed += delta * acceleration
		
		if (speed > max_speed): # IF speed > max speed --> speed = max speed
			speed = max_speed
			
	return velocity

func _physics_process(delta):
	get_input()
	check_state()
	velocity = starting_acceleration(delta, velocity)
	move_and_slide(velocity)
	position.y -= delta * gravity * -1
	$debugLabel.text = self.state

func check_state():
	if state == "broke":
		self.modulate = Color(0.7,0,0)
	elif state == "work":
		self.modulate = Color(0,0.7,0)
	elif state == "stop":
		self.modulate = Color(0,0,0.7)
		
func broke():
	if state == "work":
		state = "broke"
		robotDisabled = true
		$disabledTimer.start()

func work():
	print("working called : "+str(debugCounter))
	debugCounter += 1
	if state == "stop":
		state = "work"

func stop():
	if state == "work":
		print("state is "+str(state))
		
		state = "stop"
		print("state is "+str(state))
		
func repair():
	if state == "disabled":
		state = "work"
		
func _input(event):
	if event is InputEventKey and event.pressed:
		if player == "p1":
			if Input.is_action_pressed("p1_action"):
				print("p1 acted")
			if Input.is_action_pressed("p1_stop"):
				print("p1 stopped")
				stop()
		elif player == "p2":
			if Input.is_action_pressed("p2_action"):
				print("p2 acted")
			if Input.is_action_pressed("p2_stop"):
				print("p2 stopped")
				stop()


func _on_disabledTimer_timeout():
	print("End disability")
	state = "stop"
	robotDisabled = false
