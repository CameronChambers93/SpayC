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
	
	self.set_pos(self.get_pos() + velocity)
	#self.set_pos(self.get_pos() + velocity + Vector2((1/(timer+.2))*cos(timer*20),0).rotated(sinAng ))
	

func damageable(area):
	if (area.get_name() != "aggroArea"):
		if (area.get_parent().has_method("decrease_Health")):
			return 0
		if (area.get_parent().get_parent().get_parent().has_method("decrease_Health")):
			return 1
	else:
		return -1

func _on_Bullets_area_enter(area):
	if damageable(area) == 0:
		area.get_parent().decrease_Health(20)
		self.queue_free()
	if damageable(area) == 1:
		area.get_parent().get_parent().get_parent().decrease_Health(20)
		self.queue_free()
	
func _on_Bullets_body_enter( body ):
	if (body.has_method("damage")):
		body.decrease_Health(1000)
	self.queue_free()

func _on_Rocket_area_enter( area ):
	if damageable(area) == 0:
		area.get_parent().decrease_Health(40)
		self.queue_free()
	if damageable(area) == 1:
		area.get_parent().get_parent().get_parent().decrease_Health(40)
		self.queue_free()

func _on_Rocket_body_enter( body ):
	if (body.get_name() == "Main"):
		self.queue_free()

func _on_Shock_area_enter( area ):
	if damageable(area) == 0:
		area.get_parent().decrease_Health(40)
		self.queue_free()
	if damageable(area) == 1:
		area.get_parent().get_parent().get_parent().decrease_Health(40)
		self.queue_free()

func _on_Shock_body_enter( body ):
	if (body.get_name() == "Main"):
		self.queue_free()

func _on_Freeze_area_enter( area ):
	if damageable(area) == 0:
		area.get_parent().decrease_Health(40)
		self.queue_free()
	if damageable(area) == 1:
		area.get_parent().get_parent().get_parent().decrease_Health(40)
		self.queue_free()

func _on_Freeze_body_enter( body ):
	if (body.get_name() == "Main"):
		self.queue_free()
