"
This class represent the state of a game, containing a collection of the states of all players. This is all the necesary information to persist a game.
"
Class {
	#name : #GameState,
	#superclass : #Object,
	#instVars : [
		'board',
		'dices',
		'playersStates'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameState class >> playedBy: players onBoard: board throwing: dices [
	^ self new playedBy: players onBoard: board throwing: dices
]

{ #category : #stateLogging }
GameState >> backUpCurrentStateFor: player [
	| statesOfPlayer |
	statesOfPlayer := playersStates at: player.
	statesOfPlayer add: (playersStates at: player) last copy
]

{ #category : #accessing }
GameState >> currentPlaces [
	^ (playersStates associations
		sort:
			[ :assoc1 :assoc2 | assoc1 value last position > assoc2 value last position ])
		collect: [ :assoc | assoc key ]
]

{ #category : #accessing }
GameState >> dices [
	^ dices copy
]

{ #category : #accessing }
GameState >> includesPlayer: player [
	^ playersStates keys includes: player
]

{ #category : #accessing }
GameState >> lapOfPlayer: player [
	^ (self stateOf: player) lapNumber
]

{ #category : #'private - moving' }
GameState >> move: player [
	self backUpCurrentStateFor: player.
	self player: player moves: self rollSum.
	board
		applyEffectAt: (self positionOfPlayer: player)
		on: self
		triggeredBy: player
]

{ #category : #initialization }
GameState >> playedBy: gamePlayers onBoard: gameBoard throwing: diceSet [
	| startPlayerStatesCollection |
	startPlayerStatesCollection := OrderedCollection new.
	startPlayerStatesCollection add: (PlayerState on: 1 and: 0 and: gameBoard).
	board := gameBoard.
	dices := diceSet.
	playersStates := Dictionary new.
	gamePlayers
		do:
			[ :each | playersStates at: each put: startPlayerStatesCollection copy ]
]

{ #category : #'private - moving' }
GameState >> player: player moves: anAmount [
	(self stateOf: player) move: anAmount
]

{ #category : #accessing }
GameState >> playerHasNotFinished: player [
	^ (self lapOfPlayer: player) < board numberOfLaps
]

{ #category : #accessing }
GameState >> players [
	^ playersStates keys asOrderedCollection copy
]

{ #category : #accessing }
GameState >> positionOfPlayer: player [
	^ (self stateOf: player) position
]

{ #category : #effect }
GameState >> rewindPositionFor: player [
	| playerStates |
	playerStates := playersStates at: player.
	playerStates size <= 2
		ifTrue: [ playerStates add: (PlayerState on: 1 and: 0 and: board) ]
		ifFalse: [ | previousState |
			previousState := playerStates at: playerStates size - 2.
			playerStates
				add:
					(PlayerState
						on: previousState position
						and: previousState lapNumber
						and: board) ]
]

{ #category : #'private - moving' }
GameState >> rollSum [
	^ dices inject: 0 into: [ :sum :dice | sum + dice roll ]
]

{ #category : #accessing }
GameState >> stateOf: player [
	^ (playersStates
		at: player
		ifAbsent:
			[ AssertionFailure signal: 'Asked for a player that is not in game' ])
		last
]
