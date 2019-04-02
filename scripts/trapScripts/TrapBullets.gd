extends Area2D

var hit = false
var direction = 0
var velocity = Vector2(0,0)
var timer = 0
var sinAng = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	timer += delta
	sinAng = velocity.angle()
	self.set_pos(self.get_pos() + velocity + Vector2((1/(timer+.2))*cos(timer*20),0).rotated(sinAng ))

func _on_Bullets_area_enter(area):
	if (area.has_method("modify_health")):
		area.get_parent().modify_health(-1)
		self.queue_free()
	
	#The function actually damaging the player
func _on_Bullets_body_enter( body ):
	var groups = body.get_groups()
	if(groups.has("player")):
		body.get_node("Health Canvas").modify_health(-1)
	self.queue_free()