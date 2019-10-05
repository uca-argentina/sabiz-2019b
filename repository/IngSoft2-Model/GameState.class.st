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

{ #category : #testing }
GameState >> includesPlayer: player [
	^ playerStates keys includes: player
]

{ #category : #accessing }
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

{ #category : #'private - moving' }
GameState >> player: player advances: rollResult [
	| grossNewPosition netNewPosition actualPosition listOfPlayersStates newLapNumber |
	actualPosition := self positionOfPlayer: player.
	grossNewPosition := actualPosition + rollResult.
	netNewPosition := grossNewPosition \\ board numberOfSpots.
	newLapNumber := (self lapOfPlayer: player)
		+ (grossNewPosition // board numberOfSpots).
	listOfPlayersStates := playerStates at: player.
	listOfPlayersStates
		add: (PlayerState onPosition: netNewPosition onLapNumber: newLapNumber)
]

{ #category : #accessing }
GameState >> players [
	^ playerStates keys asOrderedCollection
]

{ #category : #accessing }
GameState >> positionOfPlayer: player [
	^ (playerStates
		at: player
		ifAbsent: [ self
				assert: [ false ]
				description: 'Asked for the position of a player that is not in game' ])
		last position
]
