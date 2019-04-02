extends Node

#The currently active scene
var currentScene = null

var music_scene = preload("res://StreamPlayer.tscn")

func _ready():
   #var music = music_scene.instance()
   #get_tree().get_root().add_child(music)
   #On load set the current scene to the last scene available
   currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
   #Demonstrate setting a global variable.
   
# create a function to switch between scenes 
func setScene(scene):
   #clean up the current scene
   currentScene.queue_free()
   for node in get_tree().get_root().get_children():
      if (currentScene.get_filename() != node.get_filename() && node.get_filename() != "" && node.get_filename() != "res://StreamPlayer.tscn"):
              node.queue_free()
   #load the file passed in as the param "scene"
   var s = ResourceLoader.load(scene)
   #create an instance of our scene
   currentScene = s.instance()
   # add scene to root
   get_tree().get_root().add_child(currentScene)

func hello():
	print("hello")