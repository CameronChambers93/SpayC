#Adam Hamed
#SpikeTrap Code
#OCTOBER 26th, 2017

extends Area2D

func _ready():
	pass

func _on_SpikeTrap_body_enter(body):
	var groups = body.get_groups()
	
	#If the player is touching the spiketrap
	if (groups.has("player")):
		#Damages the player
		body.get_node("Health Canvas").modify_health(-50)

func _process(delta):