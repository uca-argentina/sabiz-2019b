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
	| game |
	game := Game
		withNumberOfSpots: 3
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: game board numberOfSpots equals: 3
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
		should: [ Board withSpots: 0 withPlayers: {#player1} ]
			raise: AssertionFailure;
		should: [ Board withSpots: -1 withPlayers: {#player1} ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testWhereIsGivenPlayer [
]

{ #category : #tests }
BoardTest >> testWhoIsInAGivenSpot [
]
