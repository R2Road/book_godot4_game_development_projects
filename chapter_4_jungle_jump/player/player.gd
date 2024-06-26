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
