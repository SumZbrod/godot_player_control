extends KinematicBody2D

var vertical_vector = Vector3(1, 0, 0)
var horizontal_vector = Vector3(0, 1, 0)

var up_vector = Vector3(0, -1, 0)

var speed = 400
var velocity_3d = Vector3(0, 0, 1) * speed

var angle_acceleration = PI / 10
var angle_deacceleration = angle_acceleration * .6

func rotate_to(V_from, V_to:Vector3, angle):
	var rot_axis = V_from.cross(V_to).normalized()
	return V_from.rotated(rot_axis, angle)

func _process(delta):
	var z_angle = Vector3(0, 0, 1).angle_to(velocity_3d)
	var y_angle = Vector3(0, 1, 0).angle_to(velocity_3d)
	var x_angle = Vector3(1, 0, 0).angle_to(velocity_3d)
	
	$Label.text = str(y_angle)	
	if 0 <= y_angle and y_angle <= PI:
		if Input.is_action_pressed("move_up"):
			velocity_3d = rotate_to(velocity_3d, -horizontal_vector, angle_acceleration)
		
		if Input.is_action_pressed("move_down"):
			velocity_3d = rotate_to(velocity_3d, horizontal_vector, angle_acceleration)

	if 0 <= x_angle and x_angle <= PI:	
		if Input.is_action_pressed("move_right"):
			velocity_3d = rotate_to(velocity_3d, vertical_vector, angle_acceleration)			
		
		if Input.is_action_pressed("move_left"):
			velocity_3d = rotate_to(velocity_3d, vertical_vector, -angle_acceleration)			
			
	if z_angle >= angle_deacceleration:
		velocity_3d = rotate_to(velocity_3d, Vector3(0, 0, 1), angle_deacceleration)
		
	elif z_angle != 0:
		velocity_3d = Vector3(0, 0, 1) * speed
		
	move_and_slide(Vector2(velocity_3d.x, velocity_3d.y))

