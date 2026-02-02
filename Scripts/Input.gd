class_name ConveyorInput extends ConveyorBelt

@export
var targetNumber := 1

@export
var needed := 1

@export
var targetLabelPath :=  ^"Score/TargetLabel"
@export
var depoLabelPath :=  ^"Score/DepoLabel"

var targetLabel: Label
var depoLabel: Label
var open = false

var deposited := 0

func _ready() -> void:
	super()

	targetLabel = get_node_or_null(targetLabelPath)
	depoLabel = get_node_or_null(depoLabelPath)
	facing = Facing.INPUT
	sprite = get_node_or_null(spritePath)

	draw_labels()
	sprite.stop()

func draw_labels():
	targetLabel.text = str(targetNumber)
	depoLabel.text = str(deposited) + "/" + str(needed)

func trigger_input(item : Item):
	if item.is_dragging:
		return
	if item.is_pushed:
		item.is_pushed = false
		return
	sprite.play_backwards()
	item.queue_free()
	if deposited < needed:
		deposited += 1
		draw_labels()
	open = false
