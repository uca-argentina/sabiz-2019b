"
This class contains tests about the game
"
Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'additional methods' }
GameTest >> negativeNumberOfSpots [
	^ -1
]

{ #category : #'test - accessing' }
GameTest >> testCantCheckThePositionOfAPlayerThatIsNotInTheGame [
	| game |
	game := Game standard.
	self
		should: [ self assert: [ game positionOfPlayer: #PlayerFromAnotherGame ] ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithInvalidNumberOfLaps [
	self
		should: [ Game
				withNumberOfSpots: 10
				playedBy: {#player1}
				throwing: {(LoadedDice loadedWith: 6)}
				withLapsToComplete: 0 ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutDices [
	self
		should: [ Game
				withNumberOfSpots: 20
				playedBy: {#player1}
				throwing: {}
				withLapsToComplete: 2 ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutPlayers [
	self
		should: [ Game
				withNumberOfSpots: 20
				playedBy: {}
				throwing: {(RandomDice withFaces: 6)}
				withLapsToComplete: 2 ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantHaveDupplicatedPlayers [
	self
		should: [ Game
				withNumberOfSpots: 20
				playedBy: {#player1 . #player1}
				throwing: {(RandomDice withFaces: 6)}
				withLapsToComplete: 2 ]
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
	| game |
	game := Game
		withNumberOfSpots: 20
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		withLapsToComplete: 2.
	self assert: [ game numberOfLaps = 2 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenNumberOfPlayers [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		withLapsToComplete: 2.
	self assert: [ game quantityOfPlayers = 1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenNumberOfSpots [
	| game |
	game := Game
		withNumberOfSpots: 20
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		withLapsToComplete: 2.
	self assert: [ game numberOfSpots = 20 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenPlayer [
	| game |
	game := Game
		withNumberOfSpots: 20
		playedBy: {#player1}
		throwing: {(RandomDice withFaces: 6)}
		withLapsToComplete: 2.
	self assert: [ game includesPlayer: #player1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenSetOfDices [
	| game dice1 dice2 |
	dice1 := RandomDice withFaces: 6.
	dice2 := LoadedDice loadedWith: 4.
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing:
			{dice1.
			dice2}
		withLapsToComplete: 2.
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
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {3 . -4})}
		withLapsToComplete: 5.
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = -1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerCompletesALapAfterGoingOverTheLastSpot [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {7 . 4})}
		withLapsToComplete: 5.
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = 1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerLosesALapIfHeGoesBackBeyondTheFirstSpot [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(NegativeLoadedDice loadedWith: -4)}
		withLapsToComplete: 5.
	game playOneRound.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = -1 ]
]

{ #category : #'test - playing' }
GameTest >> testPlayerOneWonTheGame [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(LoadedDice loadedWith: 10)}
		withLapsToComplete: 1.
	game playOneRound.
	self assert: [ game winner = #player1 ]
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterCompletingAndLosingALap [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {-4 . 4})}
		withLapsToComplete: 5.
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 7 ].
	game playOneRound.
	self assert: [ (game positionOfPlayer: #player1) = 1 ]
]

{ #category : #'tests - instance creation' }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfSpots [
	| dice |
	dice := RandomDice withFaces: 6.
	self
		should: [ Game
				withNumberOfSpots: 0
				playedBy: {#player1}
				throwing: {dice}
				withLapsToComplete: 2 ]
			raise: AssertionFailure;
		should: [ Game
				withNumberOfSpots: self negativeNumberOfSpots
				playedBy: {#player1}
				throwing: {dice}
				withLapsToComplete: 2 ]
			raise: AssertionFailure
]

{ #category : #'test - playing' }
GameTest >> testReachingLastSpotWithoutRoundingTheBoardDoesNotIncrementLapNumber [
	| game |
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1}
		throwing: {(LoadedDice loadedWith: 9)}
		withLapsToComplete: 5.
	game playOneRound.
	self assert: [ (game lapOfPlayer: #player1) = 0 ]
]

{ #category : #'test - playing' }
GameTest >> testRiggedGameEndsAsExpected [
	| game dice |
	dice := LoadedDice loadedWith: 10.
	game := Game
		withNumberOfSpots: 10
		playedBy: {#player1 . #player2 . #player3}
		throwing: {dice}
		withLapsToComplete: 2.
	game playAnEntireGame.
	self assert: [ #player1 = game leaderBoard first ].
	self assert: [ #player2 = game leaderBoard second ].
	self assert: [ #player3 = game leaderBoard third ]
]
