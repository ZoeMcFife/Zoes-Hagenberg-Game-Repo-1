extends CharacterBody3D

@onready var pcam: PhantomCamera3D

enum{IDLE, RUN, JUMP, FALL, LAND}
var cur_anim = IDLE
@onready var rig: Node3D = $rig

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@onready var animation_tree: AnimationTree = $AnimationTree
@export var blendspeed: float = 15
@export var mouse_sensitivity: float = 0.05

@export var min_pitch: float = -89.9
@export var max_pitch: float = 50

@export var min_yaw: float = 0
@export var max_yaw: float = 360
var run_val: float = 0
var jump_val: float = 0
var falling_val: float = 0
var landing_val: float = 0

var last_dir: Vector3

var cam_rotation

func _ready() -> void:
	pcam = owner.get_node("%PhantomCamera3D")
	cam_rotation = pcam.get_third_person_rotation_degrees()
	
	
	if pcam.get_follow_mode() == pcam.FollowMode.THIRD_PERSON:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if jump_val == 1:
			cur_anim = FALL
	if is_on_floor() and cur_anim != RUN and cur_anim != IDLE:
		cur_anim = LAND

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		cur_anim = JUMP
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var camera_transform = pcam.global_transform
	var direction = (camera_transform.basis.z * input_dir.y + camera_transform.basis.x * input_dir.x)
	direction.y = 0
	direction = direction.normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if cur_anim == IDLE or cur_anim == LAND:
			cur_anim = RUN
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if cur_anim == RUN or cur_anim == LAND:
				cur_anim = IDLE
	
	if(direction.length() > 0.1):
		last_dir = direction
		
	var target_angle = atan2(last_dir.x, last_dir.z)
	rig.rotation.y = lerp_angle(rig.rotation.y, target_angle, 10 * delta)
	
	
	set_anim(delta)	
	update_animtree()
	move_and_slide()
	
	
func _unhandled_input(event: InputEvent) -> void:
	if pcam.get_follow_mode() == pcam.FollowMode.THIRD_PERSON:
		_set_pcam_rotation(pcam, event)

	
func _set_pcam_rotation(pcam: PhantomCamera3D, event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var pcam_rotation_degrees: Vector3

		# Assigns the current 3D rotation of the SpringArm3D node - so it starts off where it is in the editor
		pcam_rotation_degrees = pcam.get_third_person_rotation_degrees()

		# Change the X rotation
		pcam_rotation_degrees.x -= event.relative.y * mouse_sensitivity

		# Clamp the rotation in the X axis so it go over or under the target
		pcam_rotation_degrees.x = clampf(pcam_rotation_degrees.x, min_pitch, max_pitch)

		# Change the Y rotation value
		pcam_rotation_degrees.y -= event.relative.x * mouse_sensitivity

		# Sets the rotation to fully loop around its target, but witout going below or exceeding 0 and 360 degrees respectively
		pcam_rotation_degrees.y = wrapf(pcam_rotation_degrees.y, min_yaw, max_yaw)

		# Change the SpringArm3D node's rotation and rotate around its target
		pcam.set_third_person_rotation_degrees(pcam_rotation_degrees)
	
func update_animtree():
	animation_tree["parameters/Blend_Run/blend_amount"] = run_val
	animation_tree["parameters/Blend_Jump/blend_amount"] = jump_val
	animation_tree["parameters/Blend_Falling/blend_amount"] = falling_val
	animation_tree["parameters/Blend_Landing/blend_amount"] = landing_val
	
func set_anim(delta):
	match cur_anim:
		IDLE: 
			run_val = lerpf(run_val, 0, blendspeed * delta)
			jump_val = lerpf(jump_val, 0, blendspeed * delta)
			falling_val = lerpf(falling_val, 0, blendspeed * delta)
			landing_val = lerpf(landing_val, 0, blendspeed * delta)
		JUMP: 
			run_val = lerpf(run_val, 0, blendspeed * delta)
			jump_val = lerpf(jump_val, 1, blendspeed * delta)
			falling_val = lerpf(falling_val, 0, blendspeed * delta)
			landing_val = lerpf(landing_val, 0, blendspeed * delta)
		FALL: 
			run_val = lerpf(run_val, 0, blendspeed * delta)
			jump_val = lerpf(jump_val, 0, blendspeed * delta)
			falling_val = lerpf(falling_val, 1, blendspeed * delta)
			landing_val = lerpf(landing_val, 0, blendspeed * delta)
		LAND: 
			run_val = lerpf(run_val, 0, blendspeed * delta)
			jump_val = lerpf(jump_val, 0, blendspeed * delta)
			falling_val = lerpf(falling_val, 0, blendspeed * delta)
			landing_val = lerpf(landing_val, 1, blendspeed * delta)
		RUN: 
			run_val = lerpf(run_val, 1, blendspeed * delta)
			jump_val = lerpf(jump_val, 0, blendspeed * delta)
			falling_val = lerpf(falling_val, 0, blendspeed * delta)
			landing_val = lerpf(landing_val, 0, blendspeed * delta)
			
	
			
		
