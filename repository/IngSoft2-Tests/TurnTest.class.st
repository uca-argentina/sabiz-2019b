"
Tests for Turn and Turn class
"
Class {
	#name : #TurnTest,
	#superclass : #StandardModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnTest >> testItsThePreviousPlayerTurnUntilCallingNextTurn [
	| game |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game nextTurnWithoutPlayingCards.
	self assert: player1 equals: game currentTurn
]

{ #category : #tests }
TurnTest >> testTurnsFollowOrderOfInsertionOfPlayersInTheGame [
	| game |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	self assert: player1 equals: game nextTurnWithoutPlayingCards.
	self assert: player2 equals: game nextTurnWithoutPlayingCards.
	self assert: player1 equals: game nextTurnWithoutPlayingCards
]
