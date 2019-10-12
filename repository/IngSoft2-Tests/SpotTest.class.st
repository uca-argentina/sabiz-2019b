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

{ #category : #tests }
SpotTest >> testPlayerTriggerEmptySpot [
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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
