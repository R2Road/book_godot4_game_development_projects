# 모든 스크립트의 첫줄은 어떤 노드를 상속하는지를 나타낸다.
extends Node2D


#
@export var coin_scene : PackedScene
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
	
	# 게임 시작
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing and get_tree().get_nodes_in_group( "coins" ).size() == 0 :
		level += 1
		time_left += 5
		spawn_coins()
	
	
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
	
	# Timer 설정
	$GameTimer.start()
	
	#
	spawn_coins()


func spawn_coins():
	for i in level + 4:
		var c = coin_scene.instantiate()
		add_child( c )
		c.screensize = screensize
		c.position = Vector2( randi_range( 0, screensize.x ), randi_range( 0, screensize.y ) )


func _on_game_timer_timeout():
	time_left -= 1
	$HUD.update_timer( time_left )
	if time_left <= 0:
		game_over()	


func _on_player_hurt():
	game_over()
