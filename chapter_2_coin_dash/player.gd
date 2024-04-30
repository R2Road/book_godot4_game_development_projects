# 모든 스크립트의 첫줄은 어떤 노드를 상속하는지를 나타낸다.
extends Area2D


signal picup 	# 동전 접촉
signal hurt		# 장애물 접촉


# Variable
@export var speed = 350
var velocity = Vector2.ZERO
var screensize = Vector2( 480, 720 )


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Input.get_vector( "ui_left", "ui_right", "ui_up", "ui_down" )
	position += ( velocity * ( speed * delta ) )
	
	position.x = clamp( position.x, 0, screensize.x )
	position.y = clamp( position.y, 0, screensize.y )
	
	# Animation 설정
	if velocity.length() != 0 :
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	# Direction 설정
	if velocity.x != 0 :
		$AnimatedSprite2D.flip_h = ( 0 > velocity.x )
	
