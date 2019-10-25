"
This class contains tests about the game
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'test - accessing' }
GameTest >> testCantCheckThePositionOfAPlayerThatIsNotInTheGame [
	self
		should: [ Game standard positionOfPlayer: #PlayerFromAnotherGame ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutDices [
	self
		should: [ Game playedBy: {#player1} throwing: {} using: Board standard ]
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
				playedBy: {#player1 . #player1}
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
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ game numberOfPlayers = 1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenPlayer [
	| game |
	game := Game
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ game includesPlayer: #player1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenSetOfDices [
	| game dice1 dice2 |
	dice1 := RandomDice withFaces: 6.
	dice2 := SequentialDice withRollingSequence: {4}.
	game := Game
		playedBy: {#player1}
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

{ #category : #'test - playing' }
GameTest >> testGoingBackToLastSpotDecreasesTheCorrectNumberOfLapsOfAPlayer [
	| game |
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {3 . -4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = -1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerCompletesALapAfterGoingOverTheLastSpot [
	| game |
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {7 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerOneWonTheGame [
	| game |
	game := Game
		playedBy: {#player1 . #player2}
		throwing: {(SequentialDice withRollingSequence: {10})}
		using: Board standard.
	game playAnEntireGame.
	self assert: [ game winner = #player1 ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterCompletingAndLosingALap [
	| game |
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {-4 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 7 ].
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterLosingAndCompletingALap [
	| game |
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {-4 . 4})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 7 ].
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testReachingLastSpotWithoutRoundingTheBoardDoesNotIncrementLapNumber [
	| game |
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {9})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = 0 ]
]

{ #category : #'test - playing' }
GameTest >> testRiggedGameEndsAsExpected [
	| game dice |
	dice := SequentialDice withRollingSequence: {10}.
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {dice}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playAnEntireGame.
	self
		assert: game leaderBoardPositions
		equals: {#player1 . #player2 . #player3}
]
