"
This class contains tests about spots.
"
Class {
	#name : #SpotEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - moonwalk' }
SpotEffectTest >> testMoonWalkReducesThePositionOfAllPlayerWhoDidNotTriggerIt [
	| board game |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: (MoonWalkEffect goingBack: 3)).
			(Spot with: SpeedUpEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {(SequentialDice withSequence: {1 . 2 . 3})}
		using: board.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 2.
	self assert: (game positionOf: #player2) equals: 3.
	self assert: (game positionOf: #player3) equals: 4.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 8.
	self assert: (game lapOf: #player1) equals: -1.
	self assert: (game positionOf: #player2) equals: 2.
	self assert: (game positionOf: #player3) equals: 7
]

{ #category : #'tests - atomicbomb' }
SpotEffectTest >> testPlayerTriggersAtomicBombAndEveryoneGoesBackToFirstSpotMaintainingLaps [
	| game board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: AtomicBombEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new)}
		andLaps: 4.
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {(SequentialDice withSequence: {8 . 3 . 1})}
		using: board.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 4.
	self assert: (game lapOf: #player1) equals: 1.
	self assert: (game positionOf: #player2) equals: 4.
	self assert: (game lapOf: #player2) equals: 0.
	self assert: (game positionOf: #player3) equals: 2.
	self assert: (game lapOf: #player3) equals: 0.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 1.
	self assert: (game lapOf: #player1) equals: 3.
	self assert: (game positionOf: #player2) equals: 1.
	self assert: (game lapOf: #player2) equals: 1.
	self assert: (game positionOf: #player3) equals: 1.
	self assert: (game lapOf: #player3) equals: 0
]

{ #category : #'tests - speedup' }
SpotEffectTest >> testPlayerTriggersSpeedUpAndGoesForwardsFourSpots [
	| game board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: MoonWalkEffect new).
			(Spot with: NullEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: SpeedUpEffect new).
			(Spot with: WormHoleEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: NullEffect new).
			(Spot with: TimeMachineEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 9
]

{ #category : #'tests - speedup' }
SpotEffectTest >> testPlayerTriggersSpeedUpAtPositionFiveAndGainsALapAfterGoingForwardFourPositions [
	| game board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: WormHoleEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: NullEffect new).
			(Spot with: SpeedUpEffect new).
			(Spot with: WormHoleEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withSequence: {4})}
		using: board.
	self assert: (game lapOf: #player1) equals: 0.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 3.
	self assert: (game lapOf: #player1) equals: 1
]

{ #category : #'tests - wormhole' }
SpotEffectTest >> testPlayerTriggersWormHoleAndGoesBackFourSpots [
	| game board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: MoonWalkEffect new).
			(Spot with: SpeedUpEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: NullEffect new).
			(Spot with: WormHoleEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withSequence: {5})}
		using: board.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 2
]

{ #category : #'tests - wormhole' }
SpotEffectTest >> testPlayerTriggersWormHoleAtPositionTwoAndLosesALapAfterGoingBackFourPositions [
	| game board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: WormHoleEffect new).
			(Spot with: SpeedUpEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: NullEffect new).
			(Spot with: WormHoleEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withSequence: {6 . 1})}
		using: board.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 1.
	self assert: (game lapOf: #player1) equals: 1.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 4.
	self assert: (game lapOf: #player1) equals: 0
]

{ #category : #'tests - regular' }
SpotEffectTest >> testSpotWithRegularEffectDoesNothing [
	| game board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: MoonWalkEffect new).
			(Spot with: SpeedUpEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: NullEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 5
]

{ #category : #'tests - timemachine' }
SpotEffectTest >> testTimeMachineAtFirstMovementOfPlayerReturnsHimToFirstPositionAndZeroNumberOfLaps [
	| game board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: NullEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 1.
	self assert: (game lapOf: #player1) equals: 0
]

{ #category : #'tests - timemachine' }
SpotEffectTest >> testTimeMachineReturnsPlayerToPositionAtPreviousRound [
	| game board |
	board := Board
		with:
			{(Spot with: SpeedUpEffect new).
			(Spot with: AtomicBombEffect new).
			(Spot with: NullEffect new).
			(Spot with: WormHoleEffect new).
			(Spot with: TimeMachineEffect new).
			(Spot with: NullEffect new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withSequence: {2 . 8})}
		using: board.
	game playOneRound.
	game playOneRound.
	self assert: (game positionOf: #player1) equals: 1.
	self assert: (game lapOf: #player1) equals: 0
]