extends CharacterBody2D



############################  Export  ############################
@export var gravity = 750
@export var run_speed = 150
@export var jump_speed = -300



############################ Variable ############################
enum eState {
	IDLE,
	RUN,
	JUMP,
	HURT,
	DEAD,
}
var state = eState.IDLE



############################ Override ############################
func _ready():
	change_state( eState.IDLE )


func _physics_process( delta ):
	get_input()
	velocity.y += gravity * delta
	
	print( velocity )
	
	move_and_slide()
	
	# Jump > Idle
	if state == eState.JUMP and is_on_floor():
		change_state( eState.IDLE )
	
	# Jump > JumpDown
	if state == eState.JUMP and velocity.y > 0:
		$AnimationPlayer.play( "jump_down" )



############################   User   ############################
func reset( _position ):
	self.position = _position
	show()
	change_state( eState.IDLE )


func change_state( new_state : eState ):
	state = new_state
	match state:
		eState.IDLE:
			$AnimationPlayer.play( "idle" )
		eState.RUN:
			$AnimationPlayer.play( "run" )
		eState.HURT:
			$AnimationPlayer.play( "hurt" )
		eState.RUN:
			$AnimationPlayer.play( "jump_up" )
		eState.DEAD:
			hide()


func get_input():
	var right = Input.is_action_pressed( "right" )
	var left = Input.is_action_pressed( "left" )
	var jump = Input.is_action_just_pressed( "jump" ) # Push
	
	# 모든 상태에서 일어나는 이동
	self.velocity.x = 0
	if right:
		velocity.x += run_speed
		$Sprite2D.flip_h = false
	if left:
		velocity.x -= run_speed
		$Sprite2D.flip_h = true
	
	# 땅에 있을 때만 점프 가능
	if jump and is_on_floor():
		change_state( eState.JUMP )
		velocity.y = jump_speed
	
	# IDLE에서 움직이면 RUN 으로 변환
	if state == eState.IDLE and velocity.x != 0:
		change_state( eState.RUN )
	
	# RUN에서 가만히 서 있으면 IDLE로 변환
	if state == eState.RUN and velocity.x == 0:
		change_state( eState.IDLE )
	
	# 공중에 있으면 JUMP로 변환
	if state in [eState.IDLE, eState.RUN] and !is_on_floor():
		change_state( eState.JUMP )
