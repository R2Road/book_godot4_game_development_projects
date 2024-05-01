# 모든 스크립트의 첫줄은 어떤 노드를 상속하는지를 나타낸다.
extends Node2D


#
@export var coin_scene = PackedScene
@export var playtime = 30


#
var level = 1
var score = 0
var time_left = 0
var screensize = Vector2.ZERO
var playing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	
	# 게임 시작전에는 Player Node를 보이지 않는다.
	$Player.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
#
func new_game():
	# 기본 정보 초기화
	playing = true
	level = 1
	score = 0
	time_left = playtime
	
	# Player 설정
	$Player.start()
	$Player.show()
	
	#
	
