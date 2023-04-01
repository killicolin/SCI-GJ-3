extends KinematicBody2D

export var speed = 10
export var acceleration = 30
export var max_speed = 400
var velocity
var player = "p1"
var state = "stop"

var robotDisabled = false


func ready():
	if player == "p2":
		$AnimatedSprite.z_index = -1
		$AnimatedSprite.offset = Vector2(0, -50)

func get_input():
	var input_direction = Vector2(0,0)
	if player == "p1":
		if not robotDisabled:
			work()
			input_direction = Input.get_vector("ui_accept", "p1_right", "ui_accept", "ui_accept")
	elif player == "p2":
		if not robotDisabled:
			work()
			input_direction = Input.get_vector("ui_accept", "p2_right", "ui_accept", "ui_accept")
		
	velocity = input_direction * speed

func starting_acceleration(delta, velocity):
	if (velocity < max_speed):
		velocity += delta * acceleration
		
		if (velocity > max_speed):
			velocity = max_speed

func _physics_process(delta):
	get_input()
	check_state()
	
	move_and_slide(velocity)
	position.y -= delta * speed * -1

func check_state():
	if state == "broke":
		self.modulate = Color(50,0,0)
	elif state == "working":
		self.modulate = Color(0,50,0)
	elif state == "stop":
		self.modulate = Color(0,0,50)
		
func broke():
	if state == "work":
		state = "broke"
		robotDisabled = true
		$disabledTimer.start()

func work():
	if state == "stop":
		state = "work"

func stop():
	if state == "work":
		state = "stop"
		
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
	robotDisabled = false
