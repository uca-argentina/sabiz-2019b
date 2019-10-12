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
