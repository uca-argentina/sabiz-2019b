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
	game players
		do: [ :player | self assert: (game positionOfPlayer: player) > 1 ]
]

{ #category : #tests }
GameTest >> testCantCheckThePositionOfAPlayerThatIsNotInTheGame [
	| game |
	game := Game standard.
	self
		should: [ self assert: (game positionOfPlayer: #PlayerFromAnotherGame) ]
		raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testCantCreateGameWithoutDices [
	| game |
	self
		should:
			[ game := Game withNumberOfSpots: 20 playedBy: {#player1} throwing: {} ]
		raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testCantCreateGameWithoutPlayers [
	| game |
	self should: [ game := Game withNumberOfSpots: 20 playedBy: {  } throwing: { RandomDice withFaces: 6 } ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testCantHaveDupplicatedPlayers [
	self
		should: [ Game
				withNumberOfSpots: 20
				playedBy: {#player1 . #player1}
				throwing: {(RandomDice withFaces: 6)} ]
		raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testCantPlayMoreRoundsOnceGameIsOver [
	| game |
	game := Game standard.
	game playAnEntireGame.
	self should: [ game playOneRound ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfPlayers [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: game quantityOfPlayers equals: 1
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfSpots [
	| game |
	game := Game
		withNumberOfSpots: 20
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: game numberOfSpots equals: 20
]

{ #category : #tests }
GameTest >> testGameHasGivenPlayer [
	| game |
	game := Game
		withNumberOfSpots: 20
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: (game includesPlayer: #player1)
]

{ #category : #tests }
GameTest >> testGameHasGivenSetOfDices [
	| game dice1 dice2 |
	dice1 := RandomDice withFaces: 6.
	dice2 := LoadedDice loadedWith: 4.
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing:
			{dice1.
			dice2}.
	self
		assert:
			(game dices
				includesAll:
					{dice1.
					dice2})
]

{ #category : #tests }
GameTest >> testGameInitializesWithAllPlayerAtFirstSpot [
	| game |
	game := Game
		withNumberOfSpots: 5
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: (game positionOfPlayer: #player1) equals: 1.
	self assert: (game positionOfPlayer: #player2) equals: 1
]

{ #category : #tests }
GameTest >> testGameIsOver [
	| game |
	game := Game standard.
	game playAnEntireGame.
	self deny: game isNotOver
]

{ #category : #tests }
GameTest >> testPlayerCantMoveOnceOverTheEndLine [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}.
	game playAnEntireGame.
	self should: [ game movePlayer: #player1 ] raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testPlayerOneWonTheGame [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(LoadedDice loadedWith: 10)}.
	game playOneRound.
	self assert: game winner equals: #player1
]

{ #category : #tests }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfSpots [
	| dice |
	dice := RandomDice withFaces: 6.
	self
		should: [ Game withNumberOfSpots: 0 playedBy: {#player1} throwing: {dice} ]
			raise: AssertionFailure;
		should: [ Game
				withNumberOfSpots: self negativeNumberOfSpots
				playedBy: {#player1}
				throwing: {dice} ]
			raise: AssertionFailure
]

{ #category : #tests }
GameTest >> testRiggedGameEndsAsExpected [
	| game dice |
	dice := LoadedDice loadedWith: 10.
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1 . #player2 . #player3}
		throwing: {dice}.
	game playAnEntireGame.
	self assert: #player1 equals: game leaderBoard first.
	self assert: #player2 equals: game leaderBoard second.
	self assert: #player3 equals: game leaderBoard third
]
