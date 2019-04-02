extends Area2D

func _ready():
	pass

func _on_Rocket_Ammo_body_enter( body ):
	if (body.get_name() == "Player"):
		if (body.weapons[0][1] >= 0 && body.weapons[0][1] < body.weapons[0][2]):
			body.weapons[0][1] += 1
#			get_node("../Player").weapons[0][1] += 1
			get_node("/root/root/Player/Health Canvas/Weapon").set_text(str(body.weapons[0][0])
			+ ": " + str(body.weapons[0][1]))
			self.queue_free()