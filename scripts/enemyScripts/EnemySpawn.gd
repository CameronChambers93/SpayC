extends VisibilityNotifier2D

var circularFlyer = preload("res://scenes/enemyScenes/CircularFlyer.tscn")
var smallTrack = preload("res://scenes/enemyScenes/FastSmallTracker.tscn")
var largeTrack = preload("res://scenes/enemyScenes/LargeSlowTracker.tscn")
var horSlide = preload("res://scenes/enemyScenes/HorizontalSlider.tscn")

var enemy = {1: circularFlyer, 2: smallTrack, 3: largeTrack, 4: horSlide}
var alive = false
export (int) var enemyNumber

#1 is Basic left-right moving enemy
#2 is Basic up-down moving enemy
#3 is Fast left-right moving enemy
#4 is Fast up-down moving enemy
#5 is Slow moving, tracking enemy
#6 is Boss one, bullet-Hell, stationary

func _on_EnemyVisibility_enter_viewport( viewport ):
	if !alive:
		var enemy_scene = enemy[enemyNumber].instance()
		enemy_scene.set_pos(get_node("SpawnPoint").get_global_pos())
		get_tree().get_root().add_child(enemy_scene)
		alive = true
		enemy_scene.instancePath = self.get_path()