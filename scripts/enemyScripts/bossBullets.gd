extends Area2D

var hit = false
var direction = 0
var velocity = Vector2(0,0)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	var speed = 25
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
