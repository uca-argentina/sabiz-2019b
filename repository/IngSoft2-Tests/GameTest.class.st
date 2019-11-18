"
This class contains tests about the game
"
Class {
	#name : #GameTest,
	#superclass : #ModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartAtFirstSpot [
	| game |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		using: testResource standardBoard.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game positionOf: player2) equals: 1
]

{ #category : #'tests - game state' }
GameTest >> testAllPlayersStartAtLapZero [
	| game |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		using: testResource standardBoard.
	self assert: (game lapOf: player1) equals: 0.
	self assert: (game lapOf: player2) equals: 0
]

{ #category : #'test - accessing' }
GameTest >> testCantCheckThePositionOfAPlayerThatIsNotInTheGame [
	self
		should: [ testResource standardGame positionOf: (Player named: #PlayerFromAnotherGame) ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutDices [
	self
		should: [ Game
				playedBy: {player1}
				throwing: {}
				using: testResource standardBoard ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantCreateGameWithoutPlayers [
	self
		should: [ Game
				playedBy: {}
				throwing: {(RandomDice withFaces: 6)}
				using: testResource standardBoard ]
		raise: AssertionFailure
]

{ #category : #'tests - instance creation' }
GameTest >> testCantHaveDupplicatedPlayers [
	self
		should: [ Game
				playedBy: {player1. player1}
				throwing: {(RandomDice withFaces: 6)}
				using: testResource standardBoard ]
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
GameTest >> testGameHasGivenNumberOfPlayers [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(RandomDice withFaces: 6)}
		using: testResource standardBoard.
	self assert: game numberOfPlayers equals: 1
]

{ #category : #'test - accessing' }
GameTest >> testGameHasGivenPlayer [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(RandomDice withFaces: 6)}
		using: testResource standardBoard.
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
		using: testResource standardBoard.
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
		throwing: {(SequentialDice withSequence: {3. -4})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2).
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
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: game currentRanking equals: {player3. player2. player1}
]

{ #category : #'test - playing' }
GameTest >> testPlayerCompletesALapAfterGoingOverTheLastSpot [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {7 . 4})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2).
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
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 1).
	game playAnEntireGame.
	self assert: game winner equals: player1
]

{ #category : #'test - playing' }
GameTest >> testPositionOfPlayerIsCorrectAfterCompletingAndLosingALap [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {-4. 4})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2).
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
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2).
	game playOneRound.
	self assert: (game positionOf: player1) equals: 7.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 1
]

{ #category : #'test - playing' }
GameTest >> testReachingLastSpotWithoutRoundingTheBoardDoesNotIncrementLapNumber [
	| game |
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {9})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2).
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
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2).
	game playAnEntireGame.
	self assert: game finishRanking equals: {player1. player2. player3}
]
