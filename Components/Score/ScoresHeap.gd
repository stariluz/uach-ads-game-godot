extends Resource

class_name ScoresHeap

static var MAX_LENGTH = 10000
static var IS_OUT_OF_ARRAY = -1

var scoresHeap: Array = []
var scoresHeapLength := 0

func getRightNodeIndex(index):
	return (index * 2) + 2

func getLeftNodeIndex(index):
	return (index * 2) + 1

func getParentIndex(index):
	return (index - 1) / 2

func registerScore(score:Score):
	if scoresHeapLength < MAX_LENGTH:
		scoresHeap.append(score)
		var parentIndex = getParentIndex(scoresHeapLength)
		var aux = scoresHeapLength
		scoresHeapLength += 1
		while aux > 0 && scoresHeap[aux].value > scoresHeap[parentIndex].value:
			var temp = scoresHeap[aux]
			scoresHeap[aux] = scoresHeap[parentIndex]
			scoresHeap[parentIndex] = temp
			aux = parentIndex
			parentIndex = getParentIndex(aux)
		return aux
	else:
		return IS_OUT_OF_ARRAY
	
	print_debug(scoresHeap)

func getMaxScore():
	if scoresHeapLength > 0:
		return scoresHeap[0]
	else:
		return null

func removeTopScore():
	if scoresHeapLength == 0:
		return null
	print_debug("DEV - ScoresHeap - removeTopScore() - scoresHeap:", scoresHeap)
	var scoreRemoved = scoresHeap[0]
	scoresHeap[0] = scoresHeap.back()
	scoresHeap.pop_back()
	scoresHeapLength -= 1
	if(scoresHeapLength==0):
		return scoreRemoved
	var index = 0
	var leftChildIndex
	var rightChildIndex
	var highestPriorityScore
	var hasToContinue = true
	while hasToContinue:
		highestPriorityScore = index
		leftChildIndex = getLeftNodeIndex(index)
		rightChildIndex = getRightNodeIndex(index)

		if leftChildIndex < scoresHeapLength and scoresHeap[leftChildIndex].value > scoresHeap[highestPriorityScore].value:
			highestPriorityScore = leftChildIndex
		if rightChildIndex < scoresHeapLength and scoresHeap[rightChildIndex].value > scoresHeap[highestPriorityScore].value:
			highestPriorityScore = rightChildIndex
		if highestPriorityScore == index:
			hasToContinue = false

		print_debug("DEV - ScoresHeap - removeTopScore() - index:", index)
		print_debug("DEV - ScoresHeap - removeTopScore() - scoresHeap[index]:", scoresHeap[index])
		var temp = scoresHeap[index]
		scoresHeap[index] = scoresHeap[highestPriorityScore]
		scoresHeap[highestPriorityScore] = temp

		index = highestPriorityScore
	return scoreRemoved

func getSortedScores():
	var copyScores=scoresHeap.duplicate(true)
	var sortedScores=[]
	for i in range(scoresHeapLength):
		sortedScores.append(getMaxScore())
		removeTopScore()
	scoresHeap=copyScores.duplicate(true)
	scoresHeapLength=copyScores.size()
	print_debug("DEV - ScoresHeap - sortedScores:", scoresHeap, copyScores)
	return sortedScores

func save():
	var data = {
		"scoresHeap": scoresHeap.map(func(score): return score.save()),
		"scoresHeapLength": scoresHeapLength
	}
	return data;

static func load(data):
	var response=ScoresHeap.new()
	response.scoresHeap=data.scoresHeap.map(func(score_data)->Score: return Score.load(score_data))
	response.scoresHeapLength=data.scoresHeapLength
	return response
