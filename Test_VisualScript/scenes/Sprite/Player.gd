extends KinematicBody2D

onready var ground_ray = get_node("ground_ray")
onready var sprite = get_node("Sprite")

const ACCEL = 1500
const MAX_SPEED =  500
const FRICTION = -500
const GRAV = 4000
const JUMP_SPEED = -1500
const MIN_JUMP = -500

var acc = Vector2()
var vel = Vector2()
var anim = 'stand'

func _ready():
	set_process(true)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("ui_up") : 
		if ground_ray.is_colliding():
			vel.y = JUMP_SPEED
	if event.is_action_released('ui_up'):
		if vel.y < MIN_JUMP:
			vel.y = MIN_JUMP
	

func _process(delta):
	acc.y = GRAV
	acc.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	acc.x *= ACCEL
	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta
	
	
	vel += acc*delta
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)
	
	self.move_and_slide(vel,Vector2(0,-100))
	if self.is_on_floor():
		acc.y = 0
		vel.y = 0

	
	if abs(vel.x) < 10:
		vel.x = 0

	#set animation
	if vel.x == 0:
		anim = "stand"
	else:
		anim= "walk" 
		
	if vel.x >0 :
		sprite.set_flip_h(false)
	elif vel.x < 0:
		sprite.set_flip_h(true)
	sprite.play(anim)