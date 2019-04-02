extends KinematicBody2D

#ENEMY MASTER SCRIPT -----------------------------------

var instancePath
var audioPlayer
var runAudioInt = null

#BASIC STATISTIC VARIABLES
export (int) var maxHealth = 200
export (int) var currentHealth = 200
export (int) var damage = 25
const GRAVITY = 200.0
var velocity = Vector2()

#BASIC MOVEMENT VARIABLES
export (int) var directionH = 1
export (int) var directionV = 1
export (int) var speedH = 0
export (int) var speedV = 0
export (int) var speed = 0
export (int) var acceleration = 0

#WEAPON SPECIFIC VARIABLES
#Stops an enemy from moving for 2 seconds.
export (bool) var vulnFreeze = true
#Slows an enemy for 5 seconds.
export (bool) var vulnElectric = true

#ENEMY TYPE VARIABLE
#Set this number inside of the game to the enemy type
#you are looking for:

#1 is Basic left-right moving enemy
#2 is Basic up-down moving enemy
#3 is Fast left-right moving enemy
#4 is Fast up-down moving enemy
#5 is Slow moving, tracking enemy
#6 is Boss one, bullet-Hell, stationary

# [Speed V, Speed H, Acceleration, Damage Amount, Actions Function Reference]	
var enemyLibrary = {1: [0, 150, 10, 5, null], 2: [150, 0, 0, 5, null], 3: [0, 450, 5, 5, null], 4: [450, 0, 5, 5, null], 5: [200, 200, 2.5, 10, funcref(self, "action1")], 6: [0, 0, 0, 10, funcref(self, "action2")], 7: [0, 0, 0, 1, funcref(self, "bossBullets")]}

export (int) var enemyType = 5

#This allows the script to run when the game begins.
func _ready():
	set_process(true)
	set_fixed_process(true)
	set_process_input(true)
	if enemyType == 7:
		print(self.get_parent())
	speedH = enemyLibrary[enemyType][0]
	speedV = enemyLibrary[enemyType][1]
	acceleration = enemyLibrary[enemyType][2]
	damage = enemyLibrary[enemyType][3]

#RUNS EVERY FRAME AND SETS ENEMY TYPE
func _fixed_process(delta):
	#Enemy type should be set before this point
	
	#if normal default movement will call action
	if (enemyLibrary[enemyType][4] == null):
		action(delta)
	else: #if special movement call enemy specific function to override
		enemyLibrary[enemyType][4].call_func(delta)
	
#PUT DEFAULT ACTION/MOVEMENT CODE HERE
func action(delta):
	
	#print("default")
	
	pass
	
#PUT OVERRIDING ACTION/MOVEMENT CODE HERE - CURRENTLY USED IN ENEMY 5
func action1(delta): #tracking enemy
	#print("act1")
	var speed = 65
	var track = Vector2()
	var body = get_node("aggroArea").get_overlapping_bodies()
	
	#Tracks whether not the player is inside the enemy's Area2D (aggroArea).
	#If the player is within the Area2D, the enemy will begin to track the player.
	if(body.size() != 0):
		for tracker in body:
			if(tracker.is_in_group("player")):				
				if(tracker.get_global_pos().x < self.get_global_pos().x):
					track += Vector2(-1,0)
				if(tracker.get_global_pos().x > self.get_global_pos().x +5):
					track += Vector2(1,0)
				if(tracker.get_global_pos().y < self.get_global_pos().y +5):
					track += Vector2(0,-1)
				if(tracker.get_global_pos().y > self.get_global_pos().y):
					track += Vector2(0,1)
					
	track = track.normalized() * speed * delta
	move(track)
	
func action2(delta): #BOSS ONE: Bullet Hell and Teleporting
	#print("boss one works")
	pass
	#enemyType = 7
	
	#var position = get_node("../BossOneRoot").get_pos()	
	#var bullet = bossBullets_scene.instance()
	
	
func bossBullet(delta): #BOSS ONE BULLETS
	var speed = 100
	var track = Vector2()
	var body = get_node("aggroArea").get_overlapping_bodies()
	
	#Tracks whether not the player is inside the enemy's Area2D (aggroArea).
	#If the player is within the Area2D, the enemy will begin to track the player.
	if(body.size() != 0):
		for tracker in body:
			if(tracker.is_in_group("player")):				
				if(tracker.get_global_pos().x < self.get_global_pos().x):
					track += Vector2(-1,0)
				if(tracker.get_global_pos().x > self.get_global_pos().x +5):
					track += Vector2(1,0)
				if(tracker.get_global_pos().y < self.get_global_pos().y +5):
					track += Vector2(0,-1)
				if(tracker.get_global_pos().y > self.get_global_pos().y):
					track += Vector2(0,1)
					
	track = track.normalized() * speed * delta
	move(track)
	
	#self.set_pos(x,y)
	#self.set_pos(x,y)
	
#Placed here by ADAM; Decrements enemy Health
func decrease_Health(amount):
	currentHealth = currentHealth - amount
	#If enemy has no health left they die
	if (currentHealth <= 0):
		var position_medkit = self.get_pos()
		var medkit_scene = preload ("res://scenes/collectableScenes/Medkit.tscn")
		var medkit = medkit_scene.instance()
		medkit.set_pos(position_medkit)
		get_tree().get_root().add_child(medkit)
		get_node(instancePath).alive = false
		#audioPlayer.play("Laser3")
		queue_free()
	#Limits enemys health so it doesn't go above its maxHealth
	if (currentHealth > maxHealth):
		currentHealth = maxHealth

#Keeps the enemy within a specific Area 2D named cage.
func _on_Area2D_body_exit( body ):
	var groups = body.get_groups()
	
	if (groups.has("cage")):
		directionH = -directionH
		directionV = -directionV
		
func _on_playerDamage_body_enter( body ):
	#print(body.get_name())
	var groups = body.get_groups()
	#Print for testing purposes
	#print(str('Body entered: ', body.get_name()))
	if (groups.has("player")):
		body.get_node("Health Canvas").modify_health(-damage)
	if (enemyType == 7):
		if (body.get_name() == "Player" and body.get_name() == "Main"):
			self.queue_free()

func _on_playerDamage_area_enter( area ):
	pass


func _on_Despawn_exit_viewport( viewport ):
	if get_node(instancePath) != null:
		get_node(instancePath).alive = false
		queue_free()