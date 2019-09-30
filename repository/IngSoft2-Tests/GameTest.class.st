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
GameTest >> testCantHaveDupplicatedPlayers [
	self should: [ Game withNumberOfSpots: 20 playedBy: { Player withNumber: 1. Player withNumber: 1 } throwing: { RandomDice withFaces: 6 } ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testCantPlayMoreRoundsOnceGameIsOver [
	| game |
	game := Game standard.
	game playout.
	self should: [ game playOneRound ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfPlayers [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {(Player withNumber: 1)}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: game players size equals: 1
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfSpots [
	| game |
	game := Game
		withNumberOfSpots: 20
		playedBy: {(Player withNumber: 1)}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: game numberOfSpots equals: 20
]

{ #category : #tests }
GameTest >> testGameHasGivenPlayer [
	| game player |
	player := Player withNumber: 1.
	game := Game
		withNumberOfSpots: 20
		playedBy: {player}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: (game players includes: player)
]

{ #category : #tests }
GameTest >> testGameHasGivenSetOfDices [
	| game dice1 dice2 |
	dice1 := RandomDice withFaces: 6.
	dice2 := LoadedDice loadedWith: 4.
	game := Game
		withNumberOfSpots: 10
		playedBy: {(Player withNumber: 1)}
		throwing:
			{dice1.
			dice2}.
	self
		assert:
			(game dices
				includesAll:
					{dice1.
					dice2} asOrderedCollection)
]

{ #category : #tests }
GameTest >> testGameIsOver [
	| game player |
	game := Game standard.
	game playout.
	self assert: game isNotOver equals: false
]

{ #category : #tests }
GameTest >> testPlayerCantMoveOnceOverTheEndLine [
	| game player |
	player := Player withNumber: 1.
	game := Game
		withNumberOfSpots: 10
		playedBy: {player}
		throwing: {(RandomDice withFaces: 6)}.
	game playout.
	self should: [ game movePlayer: player ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testPlayerOneWonTheGame [
	| player game |
	player := Player withNumber: 1.
	game := Game
		withNumberOfSpots: 10
		playedBy: {player}
		throwing: {(LoadedDice loadedWith: 10)}.
	game playOneRound.
	self assert: game winner equals: player
]

{ #category : #tests }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfSpots [
	| player dice |
	player := Player withNumber: 1.
	dice := RandomDice withFaces: 6.
	self
		should:
				[ Game withNumberOfSpots: 0 playedBy: {player} throwing: {dice} ]
			raise: AssertionFailure;
		should: [ Game
				withNumberOfSpots: self negativeNumberOfSpots
				playedBy: {player}
				throwing: {dice} ]
			raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testRiggedGameEndsAsExpected [
	| player1 player2 player3 game dice |
	dice := LoadedDice loadedWith: 10.
	player1 := Player withNumber: 1.
	player2 := Player withNumber: 2.
	player3 := Player withNumber: 3.
	game := Game
		withNumberOfSpots: 10
		playedBy:
			{player1.
			player2.
			player3}
		throwing: {dice}.
	game playout.
	self assert: player1 equals: game leaderBoard first.
	self assert: player2 equals: game leaderBoard second.
	self assert: player3 equals: game leaderBoard third
]
