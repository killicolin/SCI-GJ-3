extends KinematicBody2D



export var speed = 400
var velocity

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	position.y -= delta * speed * -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
