extends KinematicBody2D

class_name Player

export var movementSpeed:float = 150
export var jumpSpeed:float = 150
var velocity:Vector2
export var gravity:float = 300
onready var leapController:LeapController = $LeapController
onready var sprite:Sprite = $Sprite
enum Direction {
	LEFT = -1,
	RIGHT = 1
}
var direction:int = Direction.RIGHT
var _interactable:Interactable
var canMove = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("player")
	Events.connect("dialogue_start",self,"on_dialogue_start")
	Events.connect("dialogue_end",self,"on_dialogue_end")
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if !canMove:
		return
	getInput()
	var inputDir:Vector2 = getMovementInput()
	var jumpInterrupted:bool = isJumpInterruped(velocity)
	var wall_sliding = is_sliding_on_wall()
	if wall_sliding:
		if velocity.y >= 0:
			velocity = applyForce(velocity,Vector2(200*get_wall_direction(),0))
		setDirection(Vector2(get_wall_direction() * -1,0))
	else:
		setDirection(inputDir)
	var leapVelocity:float = leapController.get_velocity(is_on_floor() or is_sliding_on_wall())
	var new_velocity = getPlayerVelocity(inputDir,velocity,Vector2(movementSpeed,jumpSpeed),jumpInterrupted,leapVelocity,is_on_floor(),is_sliding_on_wall())
	velocity = move_and_slide(new_velocity,Vector2.UP)
	setAnimation(direction)
	
func getPlayerVelocity(
		inputDir:Vector2,
		velocity:Vector2,
		speed:Vector2,
		jumpInterruped:bool,
		leapVelocity:float,
		onFloor:bool,
		onWall:bool
	) -> Vector2:
	var output:Vector2 = velocity
	if inputDir.x != 0 or onFloor:
		output.x = lerp(velocity.x,inputDir.x * speed.x,0.3)
	if leapVelocity > 0:
		output.y = -leapVelocity
		output.x = direction * leapVelocity
		$LeapSound.play()
	elif inputDir.y == -1:
		output.y = inputDir.y * speed.y
		$JumpSound.play()
	if jumpInterruped:
		output.y = 0
	output = applyForce(output,Vector2(0,gravity))
	if onWall:
		output = applyForce(output,Vector2(0,-gravity * 0.95))
	return output
	
func is_sliding_on_wall() -> bool:
	return $Left.is_colliding() || $Right.is_colliding()
	
func get_wall_direction() -> int:
	if $Left.is_colliding():
		return -1
	else:
		return 1
	
	

func applyForce(velocity:Vector2, force:Vector2) -> Vector2:
	velocity.y += force.y * get_physics_process_delta_time()
	velocity.x += force.x * get_physics_process_delta_time()
	return velocity
	
	
func setDirection(input:Vector2):
	if input.x > 0:
		direction = Direction.RIGHT
	elif input.x < 0:
		direction = Direction.LEFT
		
	
	
func getMovementInput() -> Vector2:
	var horizontal:float = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	var vertical:float = -1 if Input.get_action_strength("jump") and is_on_floor() else 0.0
	return Vector2(horizontal,vertical)

func getInput() -> void:
	if Input.is_action_just_pressed("interact") and _interactable != null:
		_interactable.action(self)
		
func isJumpInterruped(velocity:Vector2) -> bool:
	return Input.is_action_just_released("jump") and velocity.y < 0.0
	
func setAnimation(direction:int) -> void:
	sprite.scale = Vector2(direction,1)
	
func on_interactable_entered(interactable:Interactable) -> void:
	_interactable = interactable
	
func on_interactable_exited() -> void:
	_interactable = null
	
func on_dialogue_end():
	canMove = true
	
func on_dialogue_start():
	canMove = false


