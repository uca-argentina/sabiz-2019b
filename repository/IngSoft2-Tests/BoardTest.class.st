"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardHasGivenNumberOfSpots [
	self assert: (Board withSpots: 3) numberOfSpots equals: 3
]

{ #category : #tests }
BoardTest >> testBoardInitializesWithAllSpotsEmpty [
	| board |
	board := Board withSpots: 4.
	self assert: board players size equals: 0
]

{ #category : #tests }
BoardTest >> testGivenPlayerIsOnBoard [
]

{ #category : #tests }
BoardTest >> testPlayerAdvancedSuccessfully [
]

{ #category : #tests }
BoardTest >> testPlayersAreAddedSuccessfullyAndStartAtTheBegining [
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board withSpots: 0 ] raise: AssertionFailure;
		should: [ Board withSpots: -1 ] raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testWhereIsGivenPlayer [
]

{ #category : #tests }
BoardTest >> testWhoIsInAGivenSpot [
]
