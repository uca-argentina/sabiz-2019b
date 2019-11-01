"
A game with a given number of spots
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'leaderBoard',
		'state',
		'dices',
		'board'
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
Game >> currentRanking [
	^ state currentRanking
]

{ #category : #accesingGame }
Game >> dices [
	^ dices copy
]

{ #category : #accessingGameState }
Game >> finishRanking [
	^ leaderBoard finishRanking
]

{ #category : #accessingGameState }
Game >> isNotOver [
	^ (leaderBoard includesAll: state players) not
]

{ #category : #accesingGame }
Game >> isPlayedBy: aPlayer [
	^ state isPlayedBy: aPlayer
]

{ #category : #accessingGameState }
Game >> lapOfPlayer: player [
	^ state lapOfPlayer: player
]

{ #category : #'private - moving' }
Game >> move: player [
	| newState |
	newState := board
		newStateOf: player
		In: (state of: player)
		afterMoving: self rollSum.
	board applyEffectOn: self triggeredBy: player in: newState.
	((self playerHasNotFinished: player)
		or: (self finishRanking includes: player))
		ifFalse: [ leaderBoard add: player ]
]

{ #category : #'private - moving' }
Game >> moveAllPlayersWhoHaventFinished [
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
	self moveAllPlayersWhoHaventFinished
]

{ #category : #initialization }
Game >> playedBy: gamePlayers throwing: gameDices on: aBoard [
	leaderBoard := LeaderBoard new.
	board := aBoard.
	dices := gameDices.
	state := GameState playedBy: gamePlayers
]

{ #category : #accessingGameState }
Game >> playerHasNotFinished: player [
	^ (self lapOfPlayer: player) < board numberOfLaps
]

{ #category : #accessingGameState }
Game >> positionOfPlayer: aPlayer [
	^ state positionOfPlayer: aPlayer
]

{ #category : #'private - moving' }
Game >> rollSum [
	^ dices inject: 0 into: [ :sum :dice | sum + dice roll ]
]

{ #category : #accessingGameState }
Game >> winner [
	^ leaderBoard winner
]
