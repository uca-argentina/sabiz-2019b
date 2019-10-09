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
	| game board |
	board := Board withSpots: 10 andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}
		using: board.
	self assert: [ (game positionOfPlayer: #player1) = 1 ].
	self assert: [ (game positionOfPlayer: #player2) = 1 ]
]

{ #category : #tests }
GameStateTest >> testAllPlayersStartAtLapZero [
	| game board |
	board := Board withSpots: 10 andNumberOfLaps: 2.	
	game := Game
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}
		using: board.
	self assert: [ (game lapOfPlayer: #player1) = 0 ].
	self assert: [ (game lapOfPlayer: #player2) = 0 ]
]

{ #category : #tests }
GameStateTest >> testGameIsOver [
	| game |
	game := Game standard.
	game playAnEntireGame.
	self deny: [ game isNotOver ]
]

{ #category : #tests }
GameStateTest >> testOngoingGameShowsExpectedPlayerPlacesWhenUsingSequientialDice [
	| game board |
	board := Board withSpots: 10 andNumberOfLaps: 2.
	game := Game
		playedBy: {#player1 . #player2 . #player3}
		throwing: {(SequentialDice withRollingSequence: {1 . 2 . 3})}
		using: board.
	game playOneRound.
	self
		assert: [ game currentPlaces = {#player3 . #player2 . #player1} ]
]
