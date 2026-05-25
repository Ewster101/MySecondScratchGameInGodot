extends CharacterBody2D

var ChaSpeed = 400
var SpeedUp = 10
var SlowDown = 8
var SpawnLocation : Vector2
func _ready() -> void:
	SpawnLocation = position
	
func move_state() -> void:
	var move_vector : Vector2 = Vector2(1,1)
	var grav : Vector2 =Vector2(0,ChaSpeed)
	
	move_vector.x = Input.get_action_strength("D") - Input.get_action_strength("A")
	move_vector.y = Input.get_action_strength("W")
	rotate((PI*move_vector.x)/50)
	
	move_vector.x = cos(rotation)*move_vector.y
	move_vector.y = sin(rotation)*move_vector.y
	#print(move_vector)
	
	#var SpeedCheck = (((velocity.x)**2) + ((velocity.y)**2))**0.5
	#print(SpeedCheck)
	
	var combinedVector = (move_vector*ChaSpeed*2)+grav
	
	
	if move_vector != Vector2.ZERO:
		velocity = velocity.move_toward(combinedVector, SpeedUp)
	else:
		velocity = velocity.move_toward(grav, SlowDown)
	
	move_and_slide()
	
func _physics_process(_delta: float) -> void:
	move_state()
	if Global.PlayerDead == true:
		print("Player Hit Brick")
		position = SpawnLocation
		rotation_degrees = -90
		velocity = Vector2.ZERO
		Global.PlayerDead = false
