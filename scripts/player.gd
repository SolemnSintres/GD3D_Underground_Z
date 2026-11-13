extends CharacterBody3D

const gravity = 9.8
const speed = 4.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var moveit = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var direction = transform.basis * Vector3(moveit.x,0,moveit.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	move_and_slide()
