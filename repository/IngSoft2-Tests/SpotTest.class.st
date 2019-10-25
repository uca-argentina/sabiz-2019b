"
This class contains tests about spots.
"
Class {
	#name : #SpotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - moonwalk' }
SpotTest >> testMoonWalkGeneratesAValidNumberOfSpotsToGoBackValue [
	| board spotsToGoBack |
	board := Board
		with:
			{Regular new.
			MoonWalk new}
		andLaps: 2.
	spotsToGoBack := (board spotAt: 2) numberOfSpotsToGoBack * -1.
	self assert: [ spotsToGoBack <= 5 and: spotsToGoBack >= 1 ]
]

{ #category : #'tests - moonwalk' }
SpotTest >> testMoonWalkLoadedWithThreeReducesThreeSpotsToAllPlayerWhoDoNotTriggerIt [
	| board game |
	board := Board
		with:
			{Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			Regular new.
			(MoonWalk newLoadedWith: 3).
			SpeedUp new}
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

{ #category : #'tests - empty' }
SpotTest >> testPlayerTriggerEmptySpotAndNothingHappens [
	| game board |
	board := Board
		with:
			{Regular new.
			MoonWalk new.
			SpeedUp new.
			TimeMachine new.
			Regular new}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 5
]

{ #category : #'tests - atomicbomb' }
SpotTest >> testPlayerTriggersAtomicBombAndEveryoneGoesBackToFirstSpotMaintainingLaps [
	| game board |
	board := Board
		with:
			{Regular new.
			Regular new.
			AtomicBomb new.
			Regular new.
			Regular new}
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
SpotTest >> testPlayerTriggersSpeedUpAndGoesBackFourSpots [
	| game board |
	board := Board
		with:
			{Regular new.
			MoonWalk new.
			Regular new.
			TimeMachine new.
			SpeedUp new.
			WormHole new.
			TimeMachine new.
			Regular new.
			TimeMachine new}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {4})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 9
]

{ #category : #'tests - speedup' }
SpotTest >> testPlayerTriggersSpeedUpAtPositionFiveAndGainsALapAfterGoingForwardFourPositions [
	| game board |
	board := Board
		with:
			{Regular new.
			WormHole new.
			TimeMachine new.
			Regular new.
			SpeedUp new.
			WormHole new}
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
SpotTest >> testPlayerTriggersWormHoleAndGoesBackFourSpots [
	| game board |
	board := Board
		with:
			{Regular new.
			MoonWalk new.
			SpeedUp new.
			TimeMachine new.
			Regular new.
			WormHole new}
		andLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(SequentialDice withRollingSequence: {5})}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 2
]

{ #category : #'tests - wormhole' }
SpotTest >> testPlayerTriggersWormHoleAtPositionThreeAndLosesALapAfterGoingBackFourPositions [
	| game board |
	board := Board
		with:
			{Regular new.
			WormHole new.
			SpeedUp new.
			TimeMachine new.
			Regular new.
			WormHole new}
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
	self assert: (game lapOfPlayer: #player1) equals: 0.
]

{ #category : #'tests - timemachine' }
SpotTest >> testTimeMachineAtFirstMovementOfPlayerReturnsHimToFirstPositionAndZeroNumberOfLaps [
	| game board |
	board := Board
		with:
			{Regular new.
			Regular new.
			Regular new.
			Regular new.
			TimeMachine new.
			Regular new}
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
SpotTest >> testTimeMachineReturnsPlayerToPositionAtPreviousRound [
	| game board |
	board := Board
		with:
			{SpeedUp new.
			AtomicBomb  new.
			Regular new.
			WormHole new.
			TimeMachine new.
			Regular new}
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
