class_name ItemReceiver extends Area2D

var _validInputDirections : Array[Facing.CARDINAL]
var _item: Item
var _lockableTarget

func initialize(validInputDirections: Array[Facing.CARDINAL], lockableTarget):
	_validInputDirections = validInputDirections
	_lockableTarget = lockableTarget
	ORCHESTRATOR.registerPoll(poll, 2)

func poll() -> void:
	_item = pollForItem()

func pollForItem() -> Item:
	var areas: Array[Area2D] = get_overlapping_areas()
	areas = areas.filter(func(a):
		if a is not Item:
			return false
		return not (a as Item).isLocked()
	)

	if areas.size() == 0:
		return null

	if areas.size() > 1:
		push_warning("Multiple items in one square at position: " + str(position))

	return areas[0] as Item

func isLocked():
	return _item && _lockableTarget.isLocked()

func isFacingValid(dir: Facing.CARDINAL) -> bool:
	return dir in _validInputDirections

func getItem() -> Item:
	if _item and _item.isLocked():
		return null
	return _item

func deleteItem() -> void:
	_item.queue_free()
	_item = null
