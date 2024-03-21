extends Node2D

@export var starCount: int;

var star_scene = preload("res://scenes/star.tscn")

func _ready():
	translate(get_viewport().get_visible_rect().size / 2)
	for i in starCount:
		$".".add_child(star_scene.instantiate())
