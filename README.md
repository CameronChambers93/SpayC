# SpayC

This is the final version of SpayC, a game I created for my Sophomore Design class with 4 other students.

The game was created in Godot (https://godotengine.org/)

My major contributions are as followed:
  - <b>Scenes</b>: Every "entity" in Godot (Player, Enemies, Consumables, Menus, basically anything interactable) is defined as a Scene. A Scene consists of nodes, attributes, and usually methods to process handler events. 
    - I created all of the scenes in playerScenes/ and most of the scenes in menuScenes/.
    
  - <b>Scripts</b>: All of the game logic and physics were written in .gd format, very similar to python
    - Player.gd - This file deals with player physics and controls. Here, I wrote the controls for aiming and shooting, and the instancing of bullets and other player projectiles
    - menuScripts/ - I wrote most of these scripts for navigating through the main menu and pause menu, moving from the main menu to the game, and vice versa.
    - rocketAmmo.gd - For picking up special ammo
    
  - <b>Music</b>: I helped in implementing background music, sounds effects, and volume controls for both of them

<a href="https://docs.google.com/presentation/d/e/2PACX-1vREi6W0swDoYuUR8WHu3HRUQ9T1VTTJQce4uiEqxwsrRxEFWnPHjvNLYc4rsFEsbqWaFLQoyR96F9kY/pub?start=false&loop=false&delayms=5000">Link to our final presentation</a>
