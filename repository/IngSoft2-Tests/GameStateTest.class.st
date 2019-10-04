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
		withNumberOfSpots: 5
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: (game positionOfPlayer: #player1) equals: 1.
	self assert: (game positionOfPlayer: #player2) equals: 1
]

{ #category : #tests }
GameStateTest >> testAllPlayersStartAtRowZero [
	| game |
	game := Game
		withNumberOfSpots: 5
		playedBy: {#player1 . #player2}
		throwing: {(RandomDice withFaces: 6)}.
	self assert: (game rowOfPlayer: #player1) equals: 0.
	self assert: (game rowOfPlayer: #player2) equals: 0
]

{ #category : #tests }
GameStateTest >> testGameIsOver [
	| game |
	game := Game standard.
	game playAnEntireGame.
	self deny: game isNotOver
]
