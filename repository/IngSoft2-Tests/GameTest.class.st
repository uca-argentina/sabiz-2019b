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
	self assert: [ (game positionOf: (game playerNumber: 1)) = 1 ].
	self assert: [ (game positionOf: (game playerNumber: 2)) = 1 ]
]

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartAtLapZero [
	| game p |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ (game lapOf: (game playerNumber: 1)) = 0 ].
	self assert: [ (game lapOf: (game playerNumber: 2)) = 0 ]
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
	| game |
	game := Game
		playedBy: {(Player named: #player1)}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ game isPlayedBy: (game playerNumber: 1) ]
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
	| game |
	game := Game
		playedBy: {(Player named: #player1)}
		throwing: {(SequentialDice withSequence: {3 . -4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOf: (game playerNumber: 1)) = -1 ]
]

{ #category : #'tests - game state' }
GameTest >> testOngoingGameShowsExpectedPlayerPlacesAfterOneRound [
	| game |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2).
			(Player named: #player3)}
		throwing: {(SequentialDice withSequence: {3 . 4 . 11})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self
		assert: [ game currentRanking
				=
					{(game playerNumber: 3).
					(game playerNumber: 2).
					(game playerNumber: 1)} ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerCompletesALapAfterGoingOverTheLastSpot [
	| game |
	game := Game
		playedBy: {(Player named: #player1)}
		throwing: {(SequentialDice withSequence: {7 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOf: (game playerNumber: 1)) = 1 ]
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
	self assert: [ game winner = (game playerNumber: 1) ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterCompletingAndLosingALap [
	| game |
	game := Game
		playedBy: {(Player named: #player1)}
		throwing: {(SequentialDice withSequence: {-4 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game positionOf: (game playerNumber: 1)) = 7 ].
	game playOneRound.
	self assert: [ (game positionOf: (game playerNumber: 1)) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterLosingAndCompletingALap [
	| game |
	game := Game
		playedBy: {(Player named: #player1)}
		throwing: {(SequentialDice withSequence: {-4 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game positionOf: (game playerNumber: 1)) = 7 ].
	game playOneRound.
	self assert: [ (game positionOf: (game playerNumber: 1)) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testReachingLastSpotWithoutRoundingTheBoardDoesNotIncrementLapNumber [
	| game |
	game := Game
		playedBy: {(Player named: #player1)}
		throwing: {(SequentialDice withSequence: {9})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game lapOf: (game playerNumber: 1)) = 0 ]
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
			{(game playerNumber: 1).
			(game playerNumber: 2).
			(game playerNumber: 3)}
]
