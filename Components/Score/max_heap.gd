extends Node

const MAX_LENGTH = 10000
const IS_OUT_OF_ARRAY = -1

class Score:
	var value: int
	var word: String

var scoresHeap: Array[Score] = []
var numberOfScores := 0

func getRightNodeIndex(index):
	return (index * 2) + 2

func getLeftNodeIndex(index):
	return (index * 2) + 1

func getParentIndex(index):
	return (index - 1) / 2

func registerScore(value: int, word: String):
	if numberOfScores < MAX_LENGTH:
		var score = Score.new()
		score.value = value
		score.word = word
		scoresHeap.append(score)
		var parentIndex = getParentIndex(numberOfScores)
		var aux = numberOfScores
		numberOfScores += 1
		while aux > 0 && scoresHeap[aux].value > scoresHeap[parentIndex].value:
			var temp = scoresHeap[aux]
			scoresHeap[aux] = scoresHeap[parentIndex]
			scoresHeap[parentIndex] = temp
			aux = parentIndex
			parentIndex = getParentIndex(aux)
		return aux
	else:
		return IS_OUT_OF_ARRAY

func getNextScore():
	if numberOfScores > 0:
		return scoresHeap[0]
	else:
		return null

func removeTopScore():
	if numberOfScores == 0:
		return null
	var scoreRemoved = scoresHeap[0]
	scoresHeap[0] = scoresHeap[numberOfScores - 1]
	scoresHeap.pop_back()
	numberOfScores -= 1
	var index = 0
	var leftChildIndex
	var rightChildIndex
	var highestPriorityScore
	var hasToContinue = true
	while hasToContinue:
		highestPriorityScore = index
		leftChildIndex = getLeftNodeIndex(index)
		rightChildIndex = getRightNodeIndex(index)

		if leftChildIndex < numberOfScores and scoresHeap[leftChildIndex].value > scoresHeap[highestPriorityScore].value:
			highestPriorityScore = leftChildIndex
		if rightChildIndex < numberOfScores and scoresHeap[rightChildIndex].value > scoresHeap[highestPriorityScore].value:
			highestPriorityScore = rightChildIndex
		if highestPriorityScore == index:
			hasToContinue = false

		var temp = scoresHeap[index]
		scoresHeap[index] = scoresHeap[highestPriorityScore]
		scoresHeap[highestPriorityScore] = temp

		index = highestPriorityScore
	return scoreRemoved
