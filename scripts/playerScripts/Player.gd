#RJ Compton
#MOVEMENT CODE
#OCTOBER 1, 2017

#UPDATED by RJ OCTOBER 7, 2017 ---- JUMPING INITIAL
#UPDATED by RJ October 9, 2017 ---- JUMPING FINAL
#UPDATED by RJ October 13, 2017 --- COLLISION
#UPDATED by RJ November 17, 2017 --- DYNAMIC JUMPING FINAL

extends KinematicBody2D

const bulletDirections = {2: [Vector2(4,0),Vector2(19,65)],
 						0: [Vector2(0,4),Vector2(0,0)],
 						4: [Vector2(0,-4),Vector2(0,0)], 
 						1: [Vector2(2*sqrt(2), -sqrt(2)*2),Vector2(15,57)],
				 	 	3: [Vector2(2*sqrt(2),sqrt(2)*2),Vector2(15,78)]}

var currentWeapon = 0

var bullet_scene = preload("res://scenes/playerScenes/Bullets.tscn")
var rocket_scene = preload("res://scenes/playerScenes/Rockets.tscn")
var freeze_scene = preload("res://scenes/playerScenes/Freeze.tscn")
var shock_scene = preload("res://scenes/playerScenes/Shock.tscn")
var pause_scene = preload("res://pause_popup.tscn")

#Weapon, Current Ammo, Max Ammo
var weapons = {0: ["Rockets", 10, 5, rocket_scene],
			1: ["Freeze", 30, 3, freeze_scene],
			2: ["Shock", 10, 3, shock_scene]}

#AUDIO
var audioPlayer
var runAudioInt = null

#DIRECTIONS
var input_direction = 0
var direction = 1
var aim = 2

#TIMERS
var shootTime = 0
var runSoundTime = 0
var jumpTimer = 0

#SPEEDS
var speed_x = 0
var speed_y = 0
var velocity = Vector2()

#CONSTANTS
const MAX_SPEED = 280
const DECELERATION = 200
const ACCELERATION = 125
const GRAVITY = 1000
const JUMP_FORCE = 250
const fallSpeed = 250
var jumpCounter = 0 #CURRENTLY UNUSED
var maxJumps = 1 #CURRENTLY UNUSED

#BOOLS
var canJumpNextFrame = true

onready var sprite = get_node("Player Sprite")

#ALLOWS PROGRAM TO RUN
func _ready():
	set_process(true)
	set_process_input(true)
	audioPlayer = get_parent().get_node("SamplePlayer")
	sprite.default("stand", aim, direction, false)

#SPECIAL INPUT (JUMP)
func _input(event):
	#if jumpCounter < maxJumps and event.is_action_pressed("jump"):
	#if event.is_action_pressed("jump"):
		#speed_y = -JUMP_FORCE
		#jumpCounter += 1
		#audioPlayer.play("Jump")
		
	if event.is_action_pressed("Weapon_Up"):
		currentWeapon = (currentWeapon + 1)%3
		while weapons[currentWeapon][1] == -1:
			currentWeapon = (currentWeapon + 1)%3
		if currentWeapon == 0:
			get_node("../Player/Health Canvas/Weapon").set_text(str(get_node("../Player").weapons[currentWeapon][0])
				+ ":" + "\t" + str(get_node("../Player").weapons[currentWeapon][1]))
		else:
			get_node("../Player/Health Canvas/Weapon").set_text(str(get_node("../Player").weapons[currentWeapon][0]))
			
	if event.is_action_pressed("Weapon_Down"):
		currentWeapon = (currentWeapon + 2)%3
		while weapons[currentWeapon][1] == -1:
			currentWeapon = (currentWeapon - 1)%3
		if currentWeapon == 0:
			get_node("../Player/Health Canvas/Weapon").set_text(str(get_node("../Player").weapons[currentWeapon][0])
				+ ":" + "\t" + str(get_node("../Player").weapons[currentWeapon][1]))
		else:
			get_node("../Player/Health Canvas/Weapon").set_text(str(get_node("../Player").weapons[currentWeapon][0]))
		#print(str(currentWeapon))
		
	if event.is_action_pressed("Weapon_Shoot"):
		weaponShoot(currentWeapon)
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().set_pause(true)
		var pos = get_node("../Player/Camera2D").get_camera_pos()
		get_node("../pause_popup").set_pos(Vector2(pos.x - 140, pos.y - 170))
		get_node("../pause_popup").show()
		get_node("../pause_popup").set_process_input(true)
	
func inputProccess(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
        if (get_tree().is_paused()):
            get_tree().set_pause(false)
        else:
            get_tree().set_pause(true)
            var pos = get_node("../Player").get_pos()
            get_node("../pause_popup").set_pos(Vector2(pos.x - 80, pos.y - 120))
            get_node("../pause_popup").show()

	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("ui_up"):
		sprite.setAim(1)
		aim = 1
		
	elif Input.is_action_pressed("ui_down"):
		sprite.setAim(3)
		aim = 3
	else:
		sprite.setAim(2)
		aim = 2
	
	
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
		sprite.move(input_direction)
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
		sprite.move(input_direction)
	else:
		input_direction = 0
		sprite.stopMoving()
		
	#DYNAMIC JUMPING CODE
	#print("Timer: ", jumpTimer, "   canJump:", canJumpNextFrame,  "   Input:",Input.is_action_pressed("jump"))
	if (jumpTimer <= 0 and canJumpNextFrame and Input.is_action_pressed("jump")):
		jumpTimer = .20
		audioPlayer.play("Jump")
		#print("JumpTimer")
		
	#if (Input.is_action_pressed("jump") and jumpTimer > 0 and jumpCounter == 0) :
	if (Input.is_action_pressed("jump") and jumpTimer > 0) :
		speed_y = -JUMP_FORCE
		#jumpCounter += 1
		
	
	if (jumpTimer > 0):
		jumpTimer -= (delta)

func movementProcess(delta):
	if input_direction != direction: 
		if input_direction == 0:
			speed_x *= .9
		else:
			speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECELERATION * delta
		
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	speed_y += GRAVITY * delta
	if speed_y > fallSpeed:
		speed_y = fallSpeed
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta 
	
	var movement_remainder = move(velocity)
	
	move(velocity)
	
	#Collision
	if is_colliding():		
	#	print("AM I ON SURFACE??")
		var vector_normal = get_collision_normal()
		
		#Fixes Wall Rubbing and Acceleration Gain
		if(vector_normal.x == 1):
			speed_x = 0
			
		elif(vector_normal.x == -1):
			speed_x = .5 * speed_x
		
		#Dynamic Jumping
		if(vector_normal.y < 0):
			canJumpNextFrame = true
			#jumpCounter = 0
		else:
			canJumpNextFrame = false
			
		var final_movement = vector_normal.slide(movement_remainder)
		speed_y = vector_normal.slide(Vector2(0, speed_y)).y
		
		move(final_movement)
		
		if vector_normal == Vector2(0, -1):
			#jumpCounter = 0
			if(final_movement.x != 0):
				if runSoundTime == 0:
					runAudioInt = audioPlayer.play("Run")
					runSoundTime += delta
				else:
					runSoundTime += delta
					if runSoundTime >= 10.62:
						runSoundTime = 0
			else:
				sprite.stopMoving()
				#print("stopmovingtest")
				if(runAudioInt != null): 
					audioPlayer.stop(runAudioInt)
					runAudioInt = null
				runSoundTime = 0
	else:
		canJumpNextFrame = false
		if(runAudioInt != null): 
			audioPlayer.stop(runAudioInt)
			runAudioInt = null
		runSoundTime = 0
			

func shootingProcess(delta):
	if(shootTime > 0): 
		shootTime -= delta
	
	if Input.is_action_pressed("Main_Fire"):
		if(shootTime <= 0):
			shootTime = .25
			var position = get_node("../Player").get_pos()
			var bullet = bullet_scene.instance()
			
			bullet.velocity = bulletDirections[aim][0]
			bullet.velocity.x *= direction
			position += Vector2(0, -72)
			position.x += bulletDirections[aim][1].x * direction
			position.y += bulletDirections[aim][1].y
			bullet.set_pos(position)
			get_tree().get_root().add_child(bullet)
			audioPlayer.play("Laser")

func weaponShoot(currentWeapon):
	if (weapons[currentWeapon][1] > 0):
		#print('shooting')
		var position = get_node("../Player").get_pos()
		var weapon = weapons[currentWeapon][3].instance()
		weapon.velocity = bulletDirections[aim][0]
		weapon.velocity.x *= direction
		position -= Vector2(0,73)
		position.x += bulletDirections[aim][1].x * direction
		position.y += bulletDirections[aim][1].y
		weapon.set_pos(position)
		var rot = 0
		if (direction == -1):
			if (aim == 1):
				rot = 90
			elif (aim == 2):
				rot = 135
			else:
				rot = 180
		else:
			if (aim == 1):
				rot = 45
			elif (aim == 3):
				rot = -45
		get_tree().get_root().add_child(weapon)
		weapon.set_rot(rot)
		if currentWeapon == 0:
			weapons[currentWeapon][1] -= 1
			get_node("../Player/Health Canvas/Weapon").set_text(str(get_node("../Player").weapons[currentWeapon][0])
				+ ": " + str(get_node("../Player").weapons[currentWeapon][1]))

#func _sound():
#	var music = get_node("SamplePlayer")
#	#music.play()

#RUNS EVERY FRAME	
func _process(delta):

	#INPUT GATHERING
	inputProccess(delta)
	#MOVEMENT CALCULATIONS
	movementProcess(delta)
	#SHOOTING
	shootingProcess(delta)
	#UPDATING ANIMATION
	sprite.update(delta)
