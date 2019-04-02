#Adam Hamed
#Max HP Increase code
#OCTOBER 17th, 2017

#Updated to work correctly on October 19th
#Updated to change group name of the item October 26th

extends Area2D

func _ready():
	pass

func _on_HealthIncrease_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()

func _on_HealthIncrease_2_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()
		
func _on_HealthIncrease_3_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()
		
func _on_HealthIncrease_4_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()

func _on_HealthIncrease_5_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()

func _on_HealthIncrease_6_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()


func _on_HealthIncrease_7_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()


func _on_HealthIncrease_8_body_enter( body ):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("collectable") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()

func _process(delta):