extends Node2D
const COL_COUNT = 6
const ROW_COUNT = 5
const N = COL_COUNT * ROW_COUNT
var element_array = []


@onready var element_scene = load("res://scenes/element.tscn")
@onready var is_holding = 0

@onready var cur = $"../current"
var holding_states=[]

const size = 26
const size_half = size/2

func _ready():
	var item = element.new()
	var row = 0
	var row_len = 0
	var row_cnt = 0
	var offset = 0
	for i in range(N):
		var el = element_scene.instantiate()
		add_child(el)
		row_len = COL_COUNT
		if (row%2 == 0):
			offset = 0
		else:
			offset = size_half
		
		#el.set_placement(row, row_cnt, i)
		el.row=row
		el.col=row_cnt
		print(row, " ", row_cnt)
		element_array.append(el)
		
		var x = row_cnt*size + offset
		var y = row*size
		element_array[i].position = Vector2(x, y)
		
		row_cnt+=1
		if (row_cnt == row_len):
			row+=1
			row_cnt = 0
			
	for i in range(N):
		element_array[i].set_placement()
		#element_array[i].print_neigh()



func _process(delta):
	pass
	

