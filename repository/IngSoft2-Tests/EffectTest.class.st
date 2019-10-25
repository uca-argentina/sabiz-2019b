"
This class contains tests about spots.
"
Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - moonwalk' }
EffectTest >> testMoonWalkReducesThePositionOfAllPlayerWhoDidNotTriggerIt [
	| board game |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: (MoonWalk goingBack: 3)).
			(Spot with: SpeedUp new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {(SequentialDice withRollingSequence: {1 . 2 . 3})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 2.
	self assert: (game positionOfPlayer: #player2) equals: 3.
	self assert: (game positionOfPlayer: #player3) equals: 4.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 8.
	self assert: (game lapOfPlayer: #player1) equals: -1.
	self assert: (game positionOfPlayer: #player2) equals: 2.
	self assert: (game positionOfPlayer: #player3) equals: 7
]

{ #category : #'tests - atomicbomb' }
EffectTest >> testPlayerTriggersAtomicBombAndEveryoneGoesBackToFirstSpotMaintainingLaps [
	| game board |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: AtomicBomb new).
			(Spot with: Regular new).
			(Spot with: Regular new)}
		andLaps: 4.
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {(SequentialDice withRollingSequence: {8 . 3 . 1})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 4.
	self assert: (game lapOfPlayer: #player1) equals: 1.
	self assert: (game positionOfPlayer: #player2) equals: 4.
	self assert: (game lapOfPlayer: #player2) equals: 0.
	self assert: (game positionOfPlayer: #player3) equals: 2.
	self assert: (game lapOfPlayer: #player3) equals: 0.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 1.
	self assert: (game lapOfPlayer: #player1) equals: 3.
	self assert: (game positionOfPlayer: #player2) equals: 1.
	self assert: (game lapOfPlayer: #player2) equals: 1.
	self assert: (game positionOfPlayer: #player3) equals: 1.
	self assert: (game lapOfPlayer: #player3) equals: 0
]

{ #category : #'tests - speedup' }
EffectTest >> testPlayerTriggersSpeedUpAndGoesForwardsFourSpots [
	| game board |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: MoonWalk new).
			(Spot with: Regular new).
			(Spot with: TimeMachine new).
			(Spot with: SpeedUp new).
			(Spot with: WormHole new).
			(Spot with: TimeMachine new).
			(Spot with: Regular new).
			(Spot with: TimeMachine new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 9
]

{ #category : #'tests - speedup' }
EffectTest >> testPlayerTriggersSpeedUpAtPositionFiveAndGainsALapAfterGoingForwardFourPositions [
	| game board |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: WormHole new).
			(Spot with: TimeMachine new).
			(Spot with: Regular new).
			(Spot with: SpeedUp new).
			(Spot with: WormHole new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {4})}
		using: board.
	self assert: (game lapOfPlayer: #player1) equals: 0.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 3.
	self assert: (game lapOfPlayer: #player1) equals: 1
]

{ #category : #'tests - wormhole' }
EffectTest >> testPlayerTriggersWormHoleAndGoesBackFourSpots [
	| game board |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: MoonWalk new).
			(Spot with: SpeedUp new).
			(Spot with: TimeMachine new).
			(Spot with: Regular new).
			(Spot with: WormHole new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {5})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 2
]

{ #category : #'tests - wormhole' }
EffectTest >> testPlayerTriggersWormHoleAtPositionThreeAndLosesALapAfterGoingBackFourPositions [
	| game board |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: WormHole new).
			(Spot with: SpeedUp new).
			(Spot with: TimeMachine new).
			(Spot with: Regular new).
			(Spot with: WormHole new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {6 . 1})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 1.
	self assert: (game lapOfPlayer: #player1) equals: 1.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 4.
	self assert: (game lapOfPlayer: #player1) equals: 0
]

{ #category : #'tests - regular' }
EffectTest >> testSpotWithRegularEffectDoesNothing [
	| game board |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: MoonWalk new).
			(Spot with: SpeedUp new).
			(Spot with: TimeMachine new).
			(Spot with: Regular new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 5
]

{ #category : #'tests - timemachine' }
EffectTest >> testTimeMachineAtFirstMovementOfPlayerReturnsHimToFirstPositionAndZeroNumberOfLaps [
	| game board |
	board := Board
		with:
			{(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: Regular new).
			(Spot with: TimeMachine new).
			(Spot with: Regular new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 1.
	self assert: (game lapOfPlayer: #player1) equals: 0
]

{ #category : #'tests - timemachine' }
EffectTest >> testTimeMachineReturnsPlayerToPositionAtPreviousRound [
	| game board |
	board := Board
		with:
			{(Spot with: SpeedUp new).
			(Spot with: AtomicBomb new).
			(Spot with: Regular new).
			(Spot with: WormHole new).
			(Spot with: TimeMachine new).
			(Spot with: Regular new)}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {2 . 8})}
		using: board.
	game playOneRound.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 1.
	self assert: (game lapOfPlayer: #player1) equals: 0
]
