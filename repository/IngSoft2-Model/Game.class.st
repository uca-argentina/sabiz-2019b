"
A game with a given number of spots
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'leaderBoard',
		'state'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Game class >> checkDuplicatePlayers: players [
	self assert: players asSet size = players size
]

{ #category : #validation }
Game class >> checkPlayerQuantity: players checkDices: dices [
	self
		assert: [ players isNotEmpty ]
		description: 'Not enough players to initialize game'.
	self
		assert: [ dices isNotEmpty ]
		description: 'Tried to initialize a game with an invalid set of Dices'
]

{ #category : #'instance creation' }
Game class >> playedBy: players throwing: dices using: aBoard [
	self checkDuplicatePlayers: players.
	self checkPlayerQuantity: players checkDices: dices.
	^ self new playedBy: players throwing: dices on: aBoard
]

{ #category : #'instance creation' }
Game class >> standard [
	^ self
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
		using: Board standard
]

{ #category : #standardValues }
Game class >> standardSetOfDices [
	^ {(RandomDice withFaces: 6)}
]

{ #category : #standardValues }
Game class >> standardSetOfPlayers [
	^ {#player1 . #player2 . #player3}
]

{ #category : #accessingGameState }
Game >> currentPlaces [
	^ state currentPlaces
]

{ #category : #accesingGame }
Game >> dices [
	^ state dices
]

{ #category : #accesingGame }
Game >> includesPlayer: aPlayer [
	^ state includesPlayer: aPlayer
]

{ #category : #accessingGameState }
Game >> isNotOver [
	^ state players size > self leaderBoardPositions size
]

{ #category : #accessingGameState }
Game >> lapOfPlayer: player [
	^ state lapOfPlayer: player
]

{ #category : #accessingGameState }
Game >> leaderBoardPositions [
	^ leaderBoard positions
]

{ #category : #'private - moving' }
Game >> move: player [
	state move: player.
	((state playerHasNotFinished: player)
		or: (self leaderBoardPositions includes: player))
		ifFalse: [ leaderBoard add: player ]
]

{ #category : #'private - moving' }
Game >> moveAllPlayers [
	state players
		do: [ :player | 
			(state playerHasNotFinished: player)
				ifTrue: [ self move: player ] ]
]

{ #category : #accesingGame }
Game >> numberOfPlayers [
	^ state players size
]

{ #category : #playing }
Game >> playAnEntireGame [
	[ self isNotOver ] whileTrue: [ self playOneRound ]
]

{ #category : #playing }
Game >> playOneRound [
	self assert: [ self isNotOver ] description: 'Game is already over'.
	self moveAllPlayers
]

{ #category : #initialization }
Game >> playedBy: gamePlayers throwing: gameDices on: aBoard [
	leaderBoard := LeaderBoard new.
	state := GameState
		playedBy: gamePlayers
		onBoard: aBoard
		throwing: gameDices
]

{ #category : #accessingGameState }
Game >> positionOfPlayer: aPlayer [
	^ state positionOfPlayer: aPlayer
]

{ #category : #accessingGameState }
Game >> winner [
	^ leaderBoard winner
]
