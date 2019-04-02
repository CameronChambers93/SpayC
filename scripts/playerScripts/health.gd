#Adam Hamed
#Health Bar code
#OCTOBER 9th, 2017

#Updated to a more organized and better working version on October 17th
#Updated to handle the player death within the health script October 22nd

extends CanvasLayer

#List containing the paths of the Extra Health Crystal sprites
var ExtraHealthList = ["Control/Extra Health1", "Control/Extra Health2", "Control/Extra Health3", "Control/Extra Health4", "Control/Extra Health5", "Control/Extra Health6", "Control/Extra Health7", "Control/Extra Health8"]
var ExtraHealthAccess = StringArray(ExtraHealthList)

var maxHealth = 99
var health = 99

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	#Initializes the health bar
	get_node("Control/ProgressBar").set_value(health % 100)
	
	#Extra Health Crystals begin hidden since you dont start with extra health (frame 255 is empty)
	get_node("Control/Extra Health1").set_frame(255)
	get_node("Control/Extra Health2").set_frame(255)
	get_node("Control/Extra Health3").set_frame(255)
	get_node("Control/Extra Health4").set_frame(255)
	get_node("Control/Extra Health5").set_frame(255)
	get_node("Control/Extra Health6").set_frame(255)
	get_node("Control/Extra Health7").set_frame(255)
	get_node("Control/Extra Health8").set_frame(255)
	pass

#Here for testing. REMOVE IN FINAL VERSION
func _input(event):
	#Damages the player - implement in enemy script by doing 
	#get_node("Player/Health Canvas/Control/ProgressBar").modify_health(negative integer)
	if event.is_action_pressed("Damager"):
		modify_health(-100)
	#Heals the player (implement Medkit item)
	if event.is_action_pressed("HPIncrease"):
		modify_health(25)
	#Gives an Extra Health Crystal (implement MaxHPIncrease item)
	if event.is_action_pressed("HealthTank"):
		HealthTank()

#Unlocks Extra Health Crystals
func HealthTank():
	#Does not give you more Extra Health Crystals than the maximum allowed amount (which is 8)
	if (maxHealth < 899):
		maxHealth = maxHealth + 100
		#Upon unlocking an Extra Health Crystal you get the full 100 extra hitpoints
		modify_health(100)
	#print statement for testing purposes
	#print(maxHealth)
		
#Returns the current health, so it can be used outside this script
func get_health():
	return health
	
#Returns the current maxHealth that the player has, for use outside the script
func get_max_Health():
	return maxHealth

#Function that allows for addition or subtraction of health, and gaining of extra health bars
#To add health pass in a positive number
#To subtract health pass in a negative number
func modify_health(amount):
	health = health + amount
	
	#Prevents medkits from healing you more than your maximum health
	if (health > maxHealth):
		health = maxHealth
	#Refreshes the health bar
	get_node("Control/ProgressBar").set_value(health  % 100)
	
	#Will kill the player if their health is 0
	if (health <= 0):
		#Player dies
		get_node("/root/global").setScene("res://scenes/menuScenes/MainMenu.tscn")
		
	#Manages the appearance of Extra Health Crystal icons
	if(maxHealth / 100 >= 1):
		for i in range(1, maxHealth / 100 + 1):
			#Shows a full Extra Health Crystal when you have one
			if(health / 100 >= i):
				get_node(ExtraHealthAccess[i-1]).set_frame(0)
			#Displays an empty container, so you know it is depleted, but unlocked
			else:
				get_node(ExtraHealthAccess[i-1]).set_frame(1)

func _fixed_process(delta):