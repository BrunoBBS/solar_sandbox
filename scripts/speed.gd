extends Node

func _ready():
	Engine.time_scale  = 1


func _on_time_1x_pressed():
	Engine.time_scale  = 1

func _on_time_5x_pressed():
	Engine.time_scale  = 20


func _on_time_10x_pressed():
	Engine.time_scale  = 50
