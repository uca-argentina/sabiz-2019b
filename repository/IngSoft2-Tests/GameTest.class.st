"
This class contains tests about the game
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartAtFirstSpot [
	| game |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ (game positionOf: game players first) = 1 ].
	self assert: [ (game positionOf: game players second) = 1 ]
]

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartAtLapZero [
	| game player1 player2 |
	player1 := Player named: #player1.
	player2 := Player named: #player2.
	game := Game
		playedBy:
			{player1.
			player2}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ (game lapOf: player1) = 0 ].
	self assert: [ (game lapOf: player2) = 0 ]
]

{ #category : #'test - accessing' }
GameTest >> testCantCheckThePositionOfAPlayerThatIsNotInTheGame [
	self
		should: [ Game standard positionOf: (Player named: #PlayerFromAnotherGame) ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutDices [
	self
		should: [ Game playedBy: {Player named: #player1} throwing: {} using: Board standard ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutPlayers [
	self
		should: [ Game
				playedBy: {}
				throwing: {(RandomDice withFaces: 6)}
				using: Board standard ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantHaveDupplicatedPlayers [
	self
		should: [ Game
				playedBy:
					{(Player named: #player1).
					(Player named: #player1)}
				throwing: {(RandomDice withFaces: 6)}
				using: Board standard ]
		raise: AssertionFailure
]

{ #category : #'test - playing' }
GameTest >> testCantPlayMoreRoundsOnceGameIsOver [
	| game |
	game := Game standard.
	game playAnEntireGame.
	self should: [ game playOneRound ] raise: AssertionFailure
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenNumberOfPlayers [
	| game |
	game := Game
		playedBy: {Player named: #player1}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ game numberOfPlayers = 1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenPlayer [
	| game player1 |
	player1 := Player named: #player1.
	game := Game
		playedBy: {player1}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ game isPlayedBy: player1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenSetOfDices [
	| game dice1 dice2 |
	dice1 := RandomDice withFaces: 6.
	dice2 := SequentialDice withSequence: {4}.
	game := Game
		playedBy: {(Player named: #player1)}
		throwing:
			{dice1.
			dice2}
		using: Board standard.
	self
		assert: [ game dices
				includesAll:
					{dice1.
					dice2} ]
]

{ #category : #'tests - game state' }
GameTest >> testGameIsOver [
	| game |
	game := Game standard.
	game playAnEntireGame.
	self deny: [ game isNotOver ]
]

{ #category : #'test - playing' }
GameTest >> testGoingBackToLastSpotDecreasesTheCorrectNumberOfLapsOfAPlayer [
	| game player1 |
	player1 := Player named: #player1.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {3 . -4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOf: player1) = -1 ]
]

{ #category : #'tests - game state' }
GameTest >> testOngoingGameShowsExpectedPlayerPlacesAfterOneRound [
	| game player1 player2 player3 currentRanking |
	player1 := Player named: #player1.
	player2 := Player named: #player2.
	player3 := Player named: #player3.
	game := Game
		playedBy:
			{player1.
			player2.
			player3}
		throwing: {(SequentialDice withSequence: {3 . 4 . 11})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	currentRanking := game currentRanking.
	self assert: [currentRanking first = game players third]. 
	self assert: [currentRanking second = game players second]. 
	self assert: [currentRanking third = game players first]. 
]

{ #category : #'test - playing' }
GameTest >> testPlayerCompletesALapAfterGoingOverTheLastSpot [
	| game player1 |
	player1 := Player named: #player1.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {7 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOf: player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerOneWonTheGame [
	| game |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {10})}
		using: Board standard.
	game playAnEntireGame.
	self assert: [ game winner = game players first ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterCompletingAndLosingALap [
	| game |
	game := Game
		playedBy: {Player named: #player1}
		throwing: {(SequentialDice withSequence: {-4 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game positionOf: (game players first)) = 7 ].
	game playOneRound.
	self assert: [ (game positionOf: game players first) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterLosingAndCompletingALap [
	| game |
	game := Game
		playedBy: {Player named: #player1}
		throwing: {(SequentialDice withSequence: {-4 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game positionOf: game players first ) = 7 ].
	game playOneRound.
	self assert: [ (game positionOf: game players first) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testReachingLastSpotWithoutRoundingTheBoardDoesNotIncrementLapNumber [
	| game |
	game := Game
		playedBy: {(Player named: #player1)}
		throwing: {(SequentialDice withSequence: {9})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game lapOf: game players first) = 0 ]
]

{ #category : #'test - playing' }
GameTest >> testRiggedGameEndsAsExpected [
	| game dice |
	dice := SequentialDice withSequence: {10}.
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2).
			(Player named: #player3)}
		throwing: {dice}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playAnEntireGame.
	self
		assert: game finishRanking
		equals:
			{game players first.
			game players second.
			game players third}
]
