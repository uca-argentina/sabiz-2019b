"
This class represent the state of a game, containing a collection of the states of all players. This is all the necesary information to persist a game.
"
Class {
	#name : #GameState,
	#superclass : #Object,
	#instVars : [
		'playerStates',
		'board',
		'dices'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameState class >> newGamePlayedBy: players onBoard: board throwing: dices [
	^ self new newGamePlayedBy: players onBoard: board throwing: dices
]

{ #category : #accessing }
GameState >> currentPlaces [
	^ (playerStates associations
		sort:
			[ :assoc1 :assoc2 | assoc1 value last position > assoc2 value last position ])
		collect: [ :assoc | assoc key ]
]

{ #category : #testing }
GameState >> includesPlayer: player [
	^ playerStates keys includes: player
]

{ #category : #'playerStates - accessing' }
GameState >> lapOfPlayer: player [
	^ (playerStates at: player) last lapNumber
]

{ #category : #initialization }
GameState >> newGamePlayedBy: gamePlayers onBoard: gameBoard throwing: gameDices [
	| startPlayerStatesCollection |
	startPlayerStatesCollection := OrderedCollection new.
	startPlayerStatesCollection
		add: (PlayerState onPosition: 1 onLapNumber: 0).
	board := gameBoard.
	dices := gameDices.
	playerStates := Dictionary new.
	gamePlayers
		do: [ :each | playerStates at: each put: startPlayerStatesCollection copy ]
]

{ #category : #accessing }
GameState >> numberOfSpots [
	^ board numberOfSpots
]

{ #category : #'private - moving' }
GameState >> player: player advances: rollResult [
	| newLapNumber actualLap actualPosition netNewPosition grossNewPosition |
	(self playerHasNotFinished: player)
		ifFalse: [ ^ self ].
	actualLap := self lapOfPlayer: player.
	actualPosition := self positionOfPlayer: player.
	grossNewPosition := actualPosition + rollResult.
	newLapNumber := actualLap + (grossNewPosition // self numberOfSpots).
	netNewPosition := grossNewPosition % self numberOfSpots.
	netNewPosition = 0
		ifTrue: [ netNewPosition := self numberOfSpots.
			newLapNumber := newLapNumber - 1 ].
	self
		saveStateOfPlayer: player
		withNewLapNumber: newLapNumber
		andNewPosition: netNewPosition
]

{ #category : #'private - moving' }
GameState >> player: player triggersEffectAtPosition: position [
	(board spotAt: position) applyEffectOn: self triggeredBy: player
]

{ #category : #testing }
GameState >> playerHasNotFinished: player [
	^ (self lapOfPlayer: player) < board numberOfLaps
]

{ #category : #'playerStates - accessing' }
GameState >> players [
	^ playerStates keys asOrderedCollection copy
]

{ #category : #'playerStates - accessing' }
GameState >> positionOfPlayer: player [
	^ (playerStates
		at: player
		ifAbsent: [ AssertionFailure
				signal: 'Asked for the position of a player that is not in game' ])
		last position
]

{ #category : #'playerStates - accessing' }
GameState >> previousLapOfPlayer: aPlayer [
	^ ((playerStates at: aPlayer) at: (playerStates at: aPlayer) size - 2)
		lapNumber
]

{ #category : #'playerStates - accessing' }
GameState >> previousPositionOfPlayer: aPlayer [
	^ ((playerStates at: aPlayer) at: (playerStates at: aPlayer) size - 2)
		position
]

{ #category : #'private - moving' }
GameState >> saveStateOfPlayer: player withNewLapNumber: newLapNumber andNewPosition: netNewPosition [
	| listOfPlayersStates |
	listOfPlayersStates := playerStates at: player.
	listOfPlayersStates
		add: (PlayerState onPosition: netNewPosition onLapNumber: newLapNumber)
]

{ #category : #'playerStates - accessing' }
GameState >> sizeOfPlayerStateForPlayer: aPlayer [
	^ (playerStates at: aPlayer) size
]
