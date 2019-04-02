#Adam Hamed
#Medkit code
#OCTOBER 17th, 2017

#Updated to work correctly on October 19th
#Updated to change group name of the item October 26th

extends Area2D

func _ready():
	pass

func _on_Medkit1_body_enter(body):
	var groups = body.get_groups()
	
	#If the player is touching the medkit and doesn't have full health
	if (groups.has("collectable") && body.get_node("Health Canvas").get_health() < body.get_node("Health Canvas").get_max_Health()):
		#Adds health
		body.get_node("Health Canvas").modify_health(10)
		#Vanishes the item when its touched by player
		self.get_parent().get_parent().get_parent().get_parent().queue_free()

func _process(delta):