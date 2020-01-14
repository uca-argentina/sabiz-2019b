"
This class contains tests about spots.
"
Class {
	#name : #SpotEffectTest,
	#superclass : #StandardModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - cardgiving' }
SpotEffectTest >> testCardGivingSpotGivesOneCardToPlayerWhoTriggersIt [
	| game board |
	board := testResource effectTestingBoardWithSpots: 5 and: CardGivingEffect new at: 5. 
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {4})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self
		assert: [ (game cardsInHandOf: player1) size = 3 ]
]

{ #category : #'tests - moonwalk' }
SpotEffectTest >> testMoonWalkReducesThePositionOfAllPlayerWhoDidNotTriggerIt [
	| board game |
	board := testResource effectTestingBoardWithSpots: 8 and: (MoonWalkEffect goingBack: 3) at: 7.
	game := Game
		playedBy: {player1. player2. player3}
		throwing: {(SequentialDice withSequence: {1. 2. 3})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 2.
	self assert: (game positionOf: player2) equals: 3.
	self assert: (game positionOf: player3) equals: 4.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 8.
	self assert: (game lapOf: player1) equals: -1.
	self assert: (game positionOf: player2) equals: 2.
	self assert: (game positionOf: player3) equals: 7
]

{ #category : #'tests - atomicbomb' }
SpotEffectTest >> testPlayerTriggersAtomicBombAndEveryoneGoesBackToFirstSpotMaintainingLaps [
	| game board |
	board := testResource effectTestingBoardWithSpots: 5 and: AtomicBombEffect new at: 3.
	game := Game
		playedBy: {player1. player2. player3}
		throwing: {(SequentialDice withSequence: {8. 3. 1})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 4.
	self assert: (game lapOf: player1) equals: 1.
	self assert: (game positionOf: player2) equals: 4.
	self assert: (game lapOf: player2) equals: 0.
	self assert: (game positionOf: player3) equals: 2.
	self assert: (game lapOf: player3) equals: 0.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game lapOf: player1) equals: 3.
	self assert: (game positionOf: player2) equals: 1.
	self assert: (game lapOf: player2) equals: 1.
	self assert: (game positionOf: player3) equals: 1.
	self assert: (game lapOf: player3) equals: 0
]

{ #category : #'tests - speedup' }
SpotEffectTest >> testPlayerTriggersSpeedUpAndGoesForwardsFourSpots [
	| game board |
	board := testResource effectTestingBoardWithSpots: 9 and: SpeedUpEffect new at: 5.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {4})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 9
]

{ #category : #'tests - speedup' }
SpotEffectTest >> testPlayerTriggersSpeedUpAtPositionFiveAndGainsALapAfterGoingForwardFourPositions [
	| game board |
	board := testResource effectTestingBoardWithSpots: 6 and: SpeedUpEffect new at: 5.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {4})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	self assert: (game lapOf: player1) equals: 0.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 3.
	self assert: (game lapOf: player1) equals: 1
]

{ #category : #'tests - wormhole' }
SpotEffectTest >> testPlayerTriggersWormHoleAndGoesBackFourSpots [
	| game board |
	board := testResource effectTestingBoardWithSpots: 6 and: WormHoleEffect new at: 6.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {5})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 2
]

{ #category : #'tests - wormhole' }
SpotEffectTest >> testPlayerTriggersWormHoleAtPositionTwoAndLosesALapAfterGoingBackFourPositions [
	| game board |
	board := testResource effectTestingBoardWithSpots: 6 and: WormHoleEffect new at: 2.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {6. 1})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game lapOf: player1) equals: 1.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 4.
	self assert: (game lapOf: player1) equals: 0
]

{ #category : #'tests - regular' }
SpotEffectTest >> testSpotWithRegularEffectDoesNothing [
	| game board |
	board := testResource effectlessBoardWithSpots: 5.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {4})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 5
]

{ #category : #'tests - timemachine' }
SpotEffectTest >> testTimeMachineAtFirstMovementOfPlayerReturnsHimToFirstPositionAndZeroNumberOfLaps [
	| game board |
	board := testResource effectTestingBoardWithSpots: 6 and: TimeMachineEffect new at: 5.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {4})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game lapOf: player1) equals: 0
]

{ #category : #'tests - timemachine' }
SpotEffectTest >> testTimeMachineReturnsPlayerToPositionAtPreviousRound [
	| game board |
	board := testResource effectTestingBoardWithSpots: 6 and: TimeMachineEffect new at: 5.
	game := Game
		playedBy: {player1}
		throwing: {(SequentialDice withSequence: {2. 8})}
		on: board
		using: testResource standardDeckOfCards
		withLaps: 2.
	game playOneRound.
	game playOneRound.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game lapOf: player1) equals: 0
]
