extends KinematicBody2D

var bullets = preload("res://scenes/enemyScenes/TrapBullets.tscn")
var velocity = Vector2(0,-1)
var position = Vector2(0,0)
var canShoot = true
var timer = 0
var limiter = 0

func _ready():
	
	velocity = velocity.rotated(self.get_rot())
	velocity = velocity.normalized()
	position = self.get_pos() + get_node("Tip").get_pos().rotated(self.get_rot())
	pass

func _fixed_process(delta):
	timer += delta
	limiter -= delta
	
	if(timer > .5):
		canShoot = false
	if(timer > 3):
		canShoot = true
		timer -= 3
	
	#print("Before: ", limiter)	
	
	if(canShoot and limiter < 0):
		var bullet_scene = bullets.instance()
		bullet_scene.set_pos(position)
		bullet_scene.velocity = velocity
		get_tree().get_root().add_child(bullet_scene)
	
	if(limiter < 0):
		limiter += 0.05
	#print("After: ", limiter)
			
func _on_aggroArea_body_enter( body ):
	if (body.get_name() == "Player"):
		set_fixed_process(true)


func _on_aggroArea_body_exit( body ):
	if (body.get_name() == "Player"):
		set_fixed_process(false)
