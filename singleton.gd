extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var winner = null
var playerNb = 2
var playerColors = [Color(0.5,0.5,0.7),Color(0.7,0.5,0.5),Color(0.7,0.7,0.5),Color(0.5,0.7,0.5)]

func qwerty_to_azerty(input):
	var qwerty = "qwertyuiopasdfghjkl;zxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890,.-!'?():_+/\\<>@#^$%&*~[]{}"
	var azerty = "azertyuiopqsdfghjklmùwxcvbnAZERTYUIOPQSDFGHJKLMÙWXCVBN1234567890,.-!'?():_+/\\<>@#^$%&*~[]{}"

	var index = qwerty.find(input)
	if index >= 0:
		return azerty[index]
	else:
		return input
