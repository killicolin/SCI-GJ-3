extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = "p1"
var playerName = "Player 1"
var keysFolder = "res://Sprite/SimpleKeys/Classic/Light/Single PNGs/"
# Called when the node enters the scene tree for the first time.
func _ready():
	reassign()

func reassign():
	var id = int(player[-1])
	$PlayerId.text = playerName
	var i = InputMap.get_action_list(player+"_action")[0]
	var inputName =  i.as_text().to_upper().split(" ")[0]
	inputName = Singleton.qwerty_to_azerty(inputName)
	print("@@@"+inputName)
	
	$_action.texture = load(keysFolder+str(inputName)+".png")
	
	var i2 = InputMap.get_action_list(player+"_fake")[0]
	var inputName2 =  i2.as_text().to_upper().split(" ")[0]
	inputName2 = Singleton.qwerty_to_azerty(inputName2)
	
	print("@@@"+inputName2)
	$HBoxContainer/fakeCont/_fake.texture = load(keysFolder+str(inputName2)+".png")

	var i3 = InputMap.get_action_list(player+"_stop")[0]
	var inputName3 =  i3.as_text().to_upper().split(" ")[0]
	inputName3 = Singleton.qwerty_to_azerty(inputName3)
	
	print("@@@"+inputName3)
	$HBoxContainer/stopCont/_stop.texture = load(keysFolder+str(inputName3)+".png")

	var i4 = InputMap.get_action_list(player+"_right")[0]
	var inputName4 =  i4.as_text().to_upper().split(" ")[0]
	inputName4 = Singleton.qwerty_to_azerty(inputName4)
	
	print("@@@"+inputName4)
	$HBoxContainer/rightCont/_right.texture = load(keysFolder+str(inputName4)+".png")
	
	$RobotImg.modulate = Singleton.playerColors[id-1]
	$PlayerId.modulate = Singleton.playerColors[id-1]
