Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> negativeNumberOfSpots [
	^ -1
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfPlayers [
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfSpots [
	| board |
	board := Game withSpots: 20.
	self assert: board numberOfSpots equals: 20
]

{ #category : #tests }
GameTest >> testGameHasGivenPlayer [
]

{ #category : #tests }
GameTest >> testGameHasGivenSetOfDices [
]

{ #category : #tests }
GameTest >> testGameIsOverWhenSomeoneWins [
]

{ #category : #tests }
GameTest >> testPlayerOneWonTheGame [
]

{ #category : #tests }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfSpots [
	self
		should: [ Game withSpots: 0 ] raise: Error;
		should: [ Game withSpots: self negativeNumberOfSpots ]
			raise: Error
]

{ #category : #tests }
GameTest >> testRiggedGameEndsAsExpected [
	| player1 player2 player3 game dice |
	dice := LoadedDice loadedWith: 10.
	game := Game withSpots: 10.
	player1 := Player withNumber: 1.
	player2 := Player withNumber: 2.
	player3 := Player withNumber: 3.
	game makeMoveByPlayer: player1 advancing: dice roll.
	game makeMoveByPlayer: player2 advancing: dice roll.
	game makeMoveByPlayer: player3 advancing: dice roll.
	self assert: player1 equals: (game leaderBoard first).
	self assert: player2 equals: (game leaderBoard second).
	self assert: player3 equals: (game leaderBoard third)
]
