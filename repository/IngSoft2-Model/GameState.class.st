"
This class represent the state of a game, containing a collection of the states of all players.
"
Class {
	#name : #GameState,
	#superclass : #Object,
	#instVars : [
		'playersStates'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameState class >> playedBy: players [
	^ self new playedBy: players
]

{ #category : #adding }
GameState >> add: state for: player [
	| playerStates |
	playerStates := playersStates at: player.
	playerStates add: state
]

{ #category : #accessing }
GameState >> currentRanking [
	^ (playersStates associations
		sort:
			[ :assoc1 :assoc2 | assoc1 value last > assoc2 value last ])
		collect: [ :assoc | assoc key ]
]

{ #category : #accessing }
GameState >> isPlayedBy: player [
	^ playersStates includesKey: player
]

{ #category : #accesingPlayersState }
GameState >> lapOf: player [
	^ (self stateOf: player) lapNumber
]

{ #category : #initialization }
GameState >> playedBy: gamePlayers [
	| startPlayerStatesCollection |
	startPlayerStatesCollection := OrderedCollection new.
	startPlayerStatesCollection add: (PlayerState on: 1 and: 0).
	playersStates := Dictionary new.
	gamePlayers
		do:
			[ :each | playersStates at: each put: startPlayerStatesCollection copy ]
]

{ #category : #accessing }
GameState >> players [
	^ playersStates keys asOrderedCollection copy
]

{ #category : #accesingPlayersState }
GameState >> positionOf: player [
	^ (self stateOf: player) position
]

{ #category : #accesingPlayersState }
GameState >> stateOf: player [
	^ (playersStates
		at: player
		ifAbsent:
			[ AssertionFailure signal: 'Asked for a player that is not in game' ])
		last
]

{ #category : #accesingPlayersState }
GameState >> statesOf: player [
	^ playersStates
		at: player
		ifAbsent: [ AssertionFailure signal: 'Asked for a player that is not in game' ]
]
