"
This class contains tests about spots.
"
Class {
	#name : #SpotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpotTest >> testAllProbabilitiesAddUpToOneHundred [
	self
		assert: [ (Spot allSubclasses
				inject: 0
				into: [ :sum :each | sum + each probability ]) = 100 ]
]

{ #category : #'tests - moonwalk' }
SpotTest >> testMoonWalkGeneratesAValidNumberOfSpotsToGoBackValue [
	| board spotsToGoBack |
	board := Board
		withSpotsCollection:
			{Empty new.
			MoonWalk new}
		andNumberOfLaps: 2.
	spotsToGoBack := (board spotAt: 2) numberOfSpotsToGoBack * -1.
	self assert: [ spotsToGoBack <= 5 and: spotsToGoBack >= 1 ]
]

{ #category : #'tests - moonwalk' }
SpotTest >> testMoonWalkLoadedWithThreeReducesThreeSpotsToAllPlayerWhoDoNotTriggerIt [
	| board game |
	board := Board
		withSpotsCollection:
			{Empty new.
			Empty new.
			Empty new.
			Empty new.
			Empty new.
			Empty new.
			(MoonWalk newLoadedWith: 3).
			Empty new}
		andNumberOfLaps: 2.
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
		withSpotsCollection:
			{Empty new.
			MoonWalk new.
			SpeedUp new.
			TimeMachine new.
			Empty new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(LoadedDice loadedWith: 4)}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 5
]

{ #category : #'tests - atomicbomb' }
SpotTest >> testPlayerTriggersAtomicBombAndEveryoneGoesBackToFirstSpotMaintainingLaps [
	| game board |
	board := Board
		withSpotsCollection:
			{Empty new.
			Empty new.
			AtomicBomb new.
			Empty new.
			Empty new}
		andNumberOfLaps: 4.
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
		withSpotsCollection:
			{Empty new.
			MoonWalk new.
			Empty new.
			TimeMachine new.
			SpeedUp new.
			WormHole new.
			TimeMachine new.
			Empty new.
			TimeMachine new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(LoadedDice loadedWith: 4)}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 9
]

{ #category : #'tests - speedup' }
SpotTest >> testPlayerTriggersSpeedUpAtPositionFiveAndGainsALapAfterGoingForwardFourPositions [
	| game board |
	board := Board
		withSpotsCollection:
			{Empty new.
			WormHole new.
			TimeMachine new.
			Empty new.
			SpeedUp new.
			WormHole new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(LoadedDice loadedWith: 4)}
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
		withSpotsCollection:
			{Empty new.
			MoonWalk new.
			SpeedUp new.
			TimeMachine new.
			Empty new.
			WormHole new}
		andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1}
		throwing: {(LoadedDice loadedWith: 5)}
		using: board.
	game playOneRound.
	self assert: (game positionOfPlayer: #player1) equals: 2
]

{ #category : #'tests - wormhole' }
SpotTest >> testPlayerTriggersWormHoleAtPositionThreeAndLosesALapAfterGoingBackFourPositions [
	| game board |
	board := Board
		withSpotsCollection:
			{Empty new.
			WormHole new.
			SpeedUp new.
			TimeMachine new.
			Empty new.
			WormHole new}
		andNumberOfLaps: 2.
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
