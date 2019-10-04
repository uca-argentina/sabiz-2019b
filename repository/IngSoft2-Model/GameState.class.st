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
GameState class >> freshGamePlayedBy: players onBoard: board throwing: dices [
	^ self new freshGamePlayedBy: players onBoard: board throwing: dices
]

{ #category : #initialization }
GameState >> freshGamePlayedBy: gamePlayers onBoard: gameBoard throwing: gameDices [
	| startPlayerStatesCollection |
	startPlayerStatesCollection := OrderedCollection new.
	startPlayerStatesCollection
		add: (PlayerState onPosition: 1 onRowNumber: 0).
	board := gameBoard.
	dices := gameDices.
	playerStates := Dictionary new.
	gamePlayers
		do: [ :each | playerStates at: each put: startPlayerStatesCollection copy ]
]

{ #category : #testing }
GameState >> includesPlayer: player [
	^ playerStates keys includes: player
]

{ #category : #'private - moving' }
GameState >> player: player advances: rollResult [
	| newPosition actualPosition listOfPlayersStates |
	actualPosition := self positionOfPlayer: player.
	newPosition := actualPosition + rollResult.
	newPosition := board numberOfSpots min: newPosition.
	listOfPlayersStates := playerStates at: player.
	listOfPlayersStates
		add: (PlayerState onPosition: newPosition onRowNumber: 0)
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
				assert: false
				description: 'Asked for the position of a player that is not in game' ])
		last position
]

{ #category : #accessing }
GameState >> rowOfPlayer: player [
	^ (playerStates at: player) last rowNumber
]
