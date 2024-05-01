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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
