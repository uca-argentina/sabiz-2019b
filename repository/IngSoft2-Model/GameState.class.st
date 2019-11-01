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

{ #category : #accessing }
GameState >> currentRanking [
self assert: false description: 'Tener en cuenta laps!!!'.

	^ (playersStates associations
		sort:
			[ :assoc1 :assoc2 | assoc1 value last position > assoc2 value last position ])
		collect: [ :assoc | assoc key ]
		
]

{ #category : #accessing }
GameState >> isPlayedBy: player [
	^ playersStates includesKey: player
]

{ #category : #accesingPlayersState }
GameState >> lapOfPlayer: player [
	^ (self of: player) lapNumber
]

{ #category : #accesingPlayersState }
GameState >> of: player [
	^ (playersStates
		at: player
		ifAbsent:
			[ AssertionFailure signal: 'Asked for a player that is not in game' ])
		last
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
GameState >> positionOfPlayer: player [
	^ (self of: player) position
]
