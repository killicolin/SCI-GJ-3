extends KinematicBody2D



export var speed = 400
var velocity
var player = "p1"
var state = "stop"

func ready():
	if player == "p2":
		$AnimatedSprite.z_index = -1
		$AnimatedSprite.position = $AnimatedSprite.position + Vector2(0,50)

func get_input():
	var input_direction
	if player == "p1":
		input_direction = Input.get_vector("ui_left", "p1_right", "ui_up", "ui_down")
	elif player == "p2":
		input_direction = Input.get_vector("ui_left", "p2_right", "ui_up", "ui_down")
		
	velocity = input_direction * speed

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

func work():
	if state == "stop":
		state = "work"

func stop():
	if state == "work":
		state = "stop"
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
