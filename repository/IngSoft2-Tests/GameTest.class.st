"
This class contains tests about the game
"
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
GameTest >> testAllPlayersAdvancedAfterOneRound [
	| game |
	game := Game standard.
	game playOneRound.
	game players do: [ :player | self assert: player position > 1 ]
]

{ #category : #tests }
GameTest >> testCantAddPlayerWithDupplicateIdNumber [
	| player1A player1B game |
	player1A := Player withNumber: 1.
	player1B := Player withNumber: 1.
	game := Game standard.
	game addPlayer: player1A.
	self should: [ Game withNumberOfSpots: 20 playedBy: { Player withNumber: 1. Player withNumber: 1 } throwing: { RandomDice withFaces: 6 } ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testCantPlayMoreRoundsOnceGameIsOver [
	| game player |
	game := Game standard.
	player := Player withNumber: 1.
	game addPlayer: player.
	game playout.
	self should: [ game playOneRound ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testGameCantStartWithoutDiceOrPlayers [
	| game |
	game := Game withSpots: 10.
	self should: [ game playout ] raise: AssertionFailure.
	game addPlayer: (Player withNumber: 1).
	self should: [ game playout ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfPlayers [

	| game player |
	player := Player withNumber: 1.
	game := Game withSpots: 10.
	game addPlayer: player.
	self assert: game players size equals: 1
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfSpots [

	| game |
	game := Game withSpots: 20.
	self assert: game numberOfSpots equals: 20
]

{ #category : #tests }
GameTest >> testGameHasGivenPlayer [

	| game player |
	player := Player withNumber: 1.
	game := Game withSpots: 10.
	game addPlayer: player.
	self assert: (game players includes: player)
]

{ #category : #tests }
GameTest >> testGameHasGivenSetOfDices [

	| dices game dice |
	game := Game withSpots: 10.
	dices := OrderedCollection new.
	dice := RandomDice withFaces: 6.
	game addDice: dice.
	dices add: dice.
	dice := LoadedDice loadedWith: 4.
	game addDice: dice.
	dices add: dice.
	self assert: ((game dices includesAll: dices) and: (dices includesAll: game dices))
	
]

{ #category : #tests }
GameTest >> testGameIsOver [
	| game player |
	game := Game standard.
	player := Player withNumber: 1.
	game addPlayer: player.
	game playout.
	self assert: game isNotOver equals: false
]

{ #category : #tests }
GameTest >> testPlayerCantMoveOnceOverTheEndLine [
	| game player |
	game := Game standard.
	player := Player withNumber: 1.
	game addPlayer: player.
	game playout.
	self should: [ game makePlayerMove: player ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testPlayerOneWonTheGame [

	| dice player game |
	game := Game withSpots: 10.
	dice := LoadedDice loadedWith: 10.
	player := Player withNumber: 1.
	game addPlayer: player.
	game addDice: dice.
	game playOneRound.
	self assert: (game winner) equals: player
]

{ #category : #tests }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfSpots [
	self
		should: [ Game withSpots: 0 ] raise: AssertionFailure;
		should: [ Game withSpots: self negativeNumberOfSpots ]
			raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testRiggedGameEndsAsExpected [

	| player1 player2 player3 game dice |
	dice := LoadedDice loadedWith: 10.
	game := Game withSpots: 10.
	player1 := Player withNumber: 1.
	player2 := Player withNumber: 2.
	player3 := Player withNumber: 3.
	
	game 	addPlayer: player1;
			addPlayer: player2;
			addPlayer: player3;
			addDice: dice.
	game playout.

	self assert: player1 equals: (game leaderBoard first).
	self assert: player2 equals: (game leaderBoard second).
	self assert: player3 equals: (game leaderBoard third)
]
