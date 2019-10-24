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
	| game |
	game := Game standard.
	self
		should: [ self assert: [ game positionOfPlayer: #PlayerFromAnotherGame ] ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutDices [
	self
		should: [ Game
				playedBy: {#player1}
				throwing: {}
				using:
					(Board
						withDistribution: OverallSpotDistribution standard
						numberOfSpots: 10
						andNumberOfLaps: 2) ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutPlayers [
	self
		should: [ Game
				playedBy: {}
				throwing: {(RandomDice withFaces: 6)}
				using:
					(Board
						withDistribution: OverallSpotDistribution standard
						numberOfSpots: 10
						andNumberOfLaps: 2) ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantHaveDupplicatedPlayers [
	self
		should: [ Game
				playedBy: {#player1 . #player1}
				throwing: {(RandomDice withFaces: 6)}
				using:
					(Board
						withDistribution: OverallSpotDistribution standard
						numberOfSpots: 10
						andNumberOfLaps: 2) ]
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
GameTest >> testGameHasGivenNumberOfLaps [
	| game board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 10
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		using: board.
	self assert: [ game numberOfLaps = 2 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenNumberOfPlayers [
	| game board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 10
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		using: board.
	self assert: [ game numberOfPlayers = 1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenNumberOfSpots [
	| game board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 20
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		using: board.
	self assert: [ game numberOfSpots = 20 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenPlayer [
	| game board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 10
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		using: board.
	self assert: [ game includesPlayer: #player1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenSetOfDices [
	| game dice1 dice2 board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 10
		andNumberOfLaps: 2.
	dice1 := RandomDice withFaces: 6.
	dice2 := SequentialDice withRollingSequence: {4}.
	game := Game
		playedBy: {#player1}
		throwing:
			{dice1.
			dice2}
		using: board.
	self
		assert: [ game dices
				includesAll:
					{dice1.
					dice2} ]
]

{ #category : #'test - playing' }
GameTest >> testGoingBackToLastSpotDecreasesTheCorrectNumberOfLapsOfAPlayer [
	| game board |
	board := Board
		withSpotCollection:
			{Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {3 . -4})}
		using: board.
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = -1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerCompletesALapAfterGoingOverTheLastSpot [
	| game board |
	board := Board
		withSpotCollection:
			{Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {7 . 4})}
		using: board.
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerOneWonTheGame [
	| game board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 10
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1 . #player2}
		throwing: {(SequentialDice withRollingSequence: {10})}
		using: board.
	game playAnEntireGame.
	self assert: [ game winner = #player1 ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterCompletingAndLosingALap [
	| game board |
	board := Board
		withSpotCollection:
			{Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {-4 . 4})}
		using: board.
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 7 ].
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterLosingAndCompletingALap [
	| game board |
	board := Board
		withSpotCollection:
			{Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {-4 . 4})}
		using: board.
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 7 ].
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testReachingLastSpotWithoutRoundingTheBoardDoesNotIncrementLapNumber [
	| game board |
	board := Board
		withSpotCollection:
			{Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {9})}
		using: board.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = 0 ]
]

{ #category : #'test - playing' }
GameTest >> testRiggedGameEndsAsExpected [
	| game dice board |
	board := Board
		withDistribution: OverallSpotDistribution standard
		numberOfSpots: 10
		andNumberOfLaps: 2.
	dice := SequentialDice withRollingSequence: {10}.
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {dice}
		using: board.
	game playAnEntireGame.
	self assert: [ #player1 = game leaderBoard first ].
	self assert: [ #player2 = game leaderBoard second ].
	self assert: [ #player3 = game leaderBoard third ]
]
