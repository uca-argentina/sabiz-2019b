"
This class contains tests about GameState
"
Class {
	#name : #GameStateTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameStateTest >> testAllPlayersStartAtFirstSpot [
	| game |
	game := Game
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ (game positionOf: #player1) = 1 ].
	self assert: [ (game positionOf: #player2) = 1 ]
]

{ #category : #tests }
GameStateTest >> testAllPlayersStartAtLapZero [
	| game |
	game := Game
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}
		using: Board standard.
	self assert: [ (game lapOf: #player1) = 0 ].
	self assert: [ (game lapOf: #player2) = 0 ]
]

{ #category : #tests }
GameStateTest >> testGameIsOver [
	| game |
	game := Game standard.
	game playAnEntireGame.
	self deny: [ game isNotOver ]
]

{ #category : #tests }
GameStateTest >> testOngoingGameShowsExpectedPlayerPlacesAfterOneRound [
	| game |
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {(SequentialDice withSequence: {3 . 4 . 11})}
		using: (Board regularWithSpots: 10 andLaps: 2).
	game playOneRound.
	self
		assert: [ game currentRanking = {#player3 . #player2 . #player1} ]
]
