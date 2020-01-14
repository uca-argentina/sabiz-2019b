"
This class contains tests about the game
"
Class {
	#name : #GameTest,
	#superclass : #StandardModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartAtFirstSpot [
	| game |
	game := Game
		playedBy:	 {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		on: testResource standardBoard
		using: testResource standardDeckOfCards
		withLaps: 2.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game positionOf: player2) equals: 1
]

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartAtLapZero [
	| game |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		on: testResource standardBoard
		using: testResource standardDeckOfCards
		withLaps: 2.
	self assert: (game lapOf: player1) equals: 0.
	self assert: (game lapOf: player2) equals: 0
]

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartWithTwoCards [
	| game |
	game := testResource standardGame.
	game players
		do:
			[ :player | self assert: (game cardsInHandOf: player) size equals: 2 ]
]

{ #category : #'test - accessing' }
GameTest >> testCantCheckThePositionOfAPlayerThatIsNotInTheGame [
	self
		should: [ testResource standardGame positionOf: (Player named: #PlayerFromAnotherGame) ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithPlayersAlreadyHoldingCards [
	| player cards |
	player := Player named: #player.
	cards := player cardsInHand.
	cards add: (Card with: AccelerationEffect new).
	self
		should: [ Game
				playedBy: {player}
				throwing: testResource standardSetOfDices
				on: testResource standardBoard
				using: testResource standardDeckOfCards
				withLaps: 2 ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutDices [
	self
		should: [ Game
				playedBy: {player1}
				throwing: {}
				on: testResource standardBoard
				using: testResource standardDeckOfCards
				withLaps: 2 ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutPlayers [
	self
		should: [ Game
				playedBy: {}
				throwing: {(RandomDice withFaces: 6)}
				on: testResource standardBoard
				using: testResource standardDeckOfCards
				withLaps: 2 ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantHaveDupplicatedPlayers [
	self
		should: [ Game
				playedBy: {player1. player1}
				throwing: {(RandomDice withFaces: 6)}
				on: testResource standardBoard
				using: testResource standardDeckOfCards
				withLaps: 2 ]
		raise: AssertionFailure
]

{ #category : #'test - playing' }
GameTest >> testCantPlayMoreRoundsOnceGameIsOver [
	| game |
	game := testResource standardGame.
	game playAnEntireGame.
	self should: [ game playOneRound ] raise: AssertionFailure
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenNumberOfLaps [
	| game |
	game := Game
				playedBy: {player1. player2}
				throwing: {(RandomDice withFaces: 6)}
				on: testResource standardBoard
				using: testResource standardDeckOfCards
				withLaps: 2.
	self assert: game numberOfLaps equals: 2
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenNumberOfPlayers [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(RandomDice withFaces: 6)}
		on: testResource standardBoard
		using: testResource standardDeckOfCards
		withLaps: 2.
	self assert: game numberOfPlayers equals: 1
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenPlayer [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(RandomDice withFaces: 6)}
		on: testResource standardBoard
		using: testResource standardDeckOfCards
		withLaps: 2.
	self assert: [ game isPlayedBy: player1 ]
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenSetOfDices [
	| game dice1 dice2 |
	dice1 := RandomDice withFaces: 6.
	dice2 := SequentialDice withSequence: {4}.
	game := Game
		playedBy: {player1}
		throwing: {dice1. dice2}
		on: testResource standardBoard
		using: testResource standardDeckOfCards
		withLaps: 2.
	self
		assert: [ game dices includesAll: {dice1. dice2} ]
]

{ #category : #'tests - game state' }
GameTest >> testGameIsOver [
	| game |
	game := testResource standardGame.
	game playAnEntireGame.
	self deny: [ game isNotOver ]
]

{ #category : #'test - playing' }
GameTest >> testGoingBackToLastSpotDecreasesTheCorrectNumberOfLapsOfAPlayer [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {3 . -4})}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	game playOneRound.
	self assert: (game lapOf: player1) equals: -1
]

{ #category : #'tests - game state' }
GameTest >> testOngoingGameShowsExpectedPlayerPlacesAfterOneRound [
	| game |
	game := Game
		playedBy: {player1. player2. player3}
		throwing: {(SequentialDice withSequence: {3 . 4 . 11})}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self
		assert: game currentRanking
		equals:
			{player3.
			player2.
			player1}
]

{ #category : #'test - playing' }
GameTest >> testPlayerCompletesALapAfterGoingOverTheLastSpot [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {7 . 4})}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	game playOneRound.
	self assert: (game lapOf: player1) equals: 1
]

{ #category : #'test - playing' }
GameTest >> testPlayerOneWonTheGame [
	| game |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {10})}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playAnEntireGame.
	self assert: game winner equals: player1
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterCompletingAndLosingALap [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {-4 . 4})}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 7.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 1
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterLosingAndCompletingALap [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {-4 . 4})}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 7.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 1
]

{ #category : #tests }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfLaps [
	self
		should: [ Game
				playedBy: {player1}
				throwing: {(RandomDice withFaces: 6)}
				on: testResource standardBoard
				using: testResource standardDeckOfCards
				withLaps: 0 ]
		raise: AssertionFailure;
		should: [ Game
				playedBy: {player1}
				throwing: {(RandomDice withFaces: 6)}
				on: testResource standardBoard
				using: testResource standardDeckOfCards
				withLaps: -1 ]
		raise: AssertionFailure
]

{ #category : #'test - playing' }
GameTest >> testReachingLastSpotWithoutRoundingTheBoardDoesNotIncrementLapNumber [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {9})}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game lapOf: player1) equals: 0
]

{ #category : #'test - playing' }
GameTest >> testRiggedGameEndsAsExpected [
	| game dice |
	dice := SequentialDice withSequence: {10}.
	game := Game
		playedBy: {player1. player2. player3}
		throwing: {dice}
		on: (testResource effectlessBoardWithSpots: 10)
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playAnEntireGame.
	self
		assert: game finishRanking
		equals:
			{player1.
			player2.
			player3}
]
