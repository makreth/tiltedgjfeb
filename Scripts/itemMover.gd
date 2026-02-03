class_name ItemMover extends Area2D

var _outputTarget: ItemReceiver
var _outputDir: Facing.CARDINAL
var _linkedReceivers: Array[ItemReceiver]
var _shift: int
var _transformer: Callable = _no_op_transformer

func initialize(outputDir: Facing.CARDINAL, linkedReceivers: Array[ItemReceiver], shift: int = 64 ) -> void:
	_outputDir = outputDir
	_shift = shift
	_linkedReceivers = linkedReceivers
	ORCHESTRATOR.registerPoll(poll, 2)
	ORCHESTRATOR.registerExecute(pushItem, 2)

## Set the transform function to apply to Items received by the linked ItemReceivers:
## 
## callback(Array[Items]) -> Item
## 
## The transform function will apply to the Items, then the items are destroyed if the result
## item is different. If the result item is the same, the Item is preserved.
## The resulting item is then pushed to the outputTarget: ItemReceiver.
func setTransformFunction(callback: Callable) -> void:
	_transformer = callback

static func _no_op_transformer(items: Array[Item]) -> Item:
	return items[0]

func poll() -> void:
	_outputTarget = pollForTarget()

func pollForTarget() -> ItemReceiver:
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true
	query.position = Facing.adjacent(_outputDir, global_position, _shift)

	var hits: Array[Dictionary] = get_world_2d().direct_space_state.intersect_point(query, 8)
	hits = hits.filter(func(d):
		if d.collider is not ItemReceiver:
			return false
		var i = d.collider as ItemReceiver
		return i.isFacingValid(_outputDir)
	)

	if hits.size() == 0:
		return null

	if hits.size() > 1:
		push_warning("Multiple receivers in one square at position: " + str(query.position))

	return hits[0].collider

func _prepareItemsForPush() -> Array[Item]:
	var result: Array[Item] = []
	for receiver in _linkedReceivers:
		var currItem = receiver.getItem()
		print(currItem)
		if currItem and not currItem.isLocked():
			result.append(currItem)
	return result

static func deleteItems(items: Array[Item]) -> void:
	for i in range(items.size()):
		items[i].queue_free()
		
func pushItem() -> void:
	if not _outputTarget:
		return
	var items = _prepareItemsForPush()
	if items.size() != _linkedReceivers.size():
		return
	if _outputTarget.isLocked():
		return
	var resultItem = _transformer.call(items)
	print(resultItem)
	if items.size() > 1:
		deleteItems(items)
	if items.get(0).value != resultItem.value:
		deleteItems(items)
	resultItem.global_position =  Facing.adjacent(_outputDir, global_position, _shift)
	
func isLocked() -> bool:
	if not _outputTarget:
		return true
	return _outputTarget.isLocked()
		
