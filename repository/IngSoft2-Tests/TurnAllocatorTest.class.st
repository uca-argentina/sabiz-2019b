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
	self assert: turns playerWhoseTurnItIsToPlay equals: player1.
	self assert: turns playerWhoseTurnItIsToPlay equals: player1.
	turns advanceTurnWheel.
	self assert: turns playerWhoseTurnItIsToPlay equals: player2.
]

{ #category : #tests }
TurnAllocatorTest >> testTurnAllocatorRespectsExpectedOrder [
	| turns |
	turns := TurnAllocator for: { player1. player2. player3 }.
	self assert: turns playerWhoseTurnItIsToPlay equals: player1.
	turns advanceTurnWheel.
	self assert: turns playerWhoseTurnItIsToPlay equals: player2.
	turns advanceTurnWheel.
	self assert: turns playerWhoseTurnItIsToPlay equals: player3.
	turns advanceTurnWheel.
	self assert: turns playerWhoseTurnItIsToPlay equals: player1
]

{ #category : #tests }
TurnAllocatorTest >> testTurnAllocatorReturnsNilWhenAskedForTheTurnOfAFinishedGame [
	| allocator |
	allocator := TurnAllocator for: { player1. player2 }.
	allocator playerHasFinished: player1.
	allocator playerHasFinished: player2.
	self assert: allocator playerWhoseTurnItIsToPlay equals: 	nil
]

{ #category : #tests }
TurnAllocatorTest >> testTurnAllocatorYieldsExpectedRoundNumber [
	| turns |
	turns := TurnAllocator for: { player1. player2. player3 }.
	self assert: turns currentRoundNumber equals: 1.
	turns advanceTurnWheel.
	self assert: turns currentRoundNumber equals: 1.
	turns advanceTurnWheel.
	self assert: turns currentRoundNumber equals: 1.
	turns advanceTurnWheel.
	self assert: turns currentRoundNumber equals: 2
]
