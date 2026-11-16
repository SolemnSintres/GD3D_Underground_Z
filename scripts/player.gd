extends CharacterBody3D

const gravity = 9.8
const speed = 4.0
const mouse = 0.002

@onready var headlight = $Head/Flashlight
@onready var head =  $Head
@onready var footsteps = $Footsteps

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	headlight.visible = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var moveit = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var direction = transform.basis * Vector3(moveit.x,0,moveit.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	move_and_slide()
	
	if is_moving() and not footsteps.playing:
		footsteps.volume_db = randf_range(-6,0)
		footsteps.play()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse)
		head.rotate_x(-event.relative.y * mouse)
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-85.0),deg_to_rad(85.0))
	if Input.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("flashlight"):
		headlight.visible = not headlight.visible

func is_moving() -> bool:
	var current_speed = Vector2(velocity.x,velocity.z).length()
	return is_on_floor() and current_speed > 0.1
