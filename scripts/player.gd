extends CharacterBody3D

const gravity = 9.8
const speed = 4.0
const mouse = 0.002

@onready var head =  $Head

func _readY():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var moveit = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var direction = transform.basis * Vector3(moveit.x,0,moveit.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse)
		head.rotate_x(-event.relative.y * mouse)
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-85.0),deg_to_rad(85.0))
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
