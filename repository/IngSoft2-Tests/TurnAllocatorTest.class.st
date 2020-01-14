"
Tests for TurnAllocator class
"
Class {
	#name : #TurnAllocatorTest,
	#superclass : #StandardModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnAllocatorTest >> testCantCreateTurnAllocatorWithEmptyCollection [
	self should: [TurnAllocator for: {}] raise: AssertionFailure
]

{ #category : #tests }
TurnAllocatorTest >> testItsThePreviousPlayersTurnUntilAdvancingTheTurnWheel [
	| turns |
	turns := TurnAllocator for: { player1. player2 }.
	self assert: turns currentTurn equals: player1.
	self assert: turns currentTurn equals: player1.
	turns advanceTurnWheel.
	self assert: turns currentTurn equals: player2.
]

{ #category : #tests }
TurnAllocatorTest >> testTurnAllocatorRespectsExpectedOrder [
	| turns |
	turns := TurnAllocator for: { player1. player2. player3 }.
	self assert: turns currentTurn equals: player1.
	turns advanceTurnWheel.
	self assert: turns currentTurn equals: player2.
	turns advanceTurnWheel.
	self assert: turns currentTurn equals: player3.
	turns advanceTurnWheel.
	self assert: turns currentTurn equals: player1.
	turns advanceTurnWheel.
]
