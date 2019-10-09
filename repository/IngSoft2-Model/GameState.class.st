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
	| grossNewPosition netNewPosition actualPosition listOfPlayersStates newLapNumber actualLap |
	actualLap := self lapOfPlayer: player.
	actualPosition := self positionOfPlayer: player.
	grossNewPosition := actualPosition + rollResult.
	newLapNumber := actualLap + (grossNewPosition // board numberOfSpots).
	netNewPosition := grossNewPosition % board numberOfSpots.
	netNewPosition = 0
		ifTrue:
			[ "If the position is at zero, it means it is in the last position of the lap, not the first position
		therefore, we subtract 1 from the total laps since the player hasnt crossed the line just yet"
			netNewPosition := board numberOfSpots.
			newLapNumber := newLapNumber - 1 ].
	listOfPlayersStates := playerStates at: player.
	listOfPlayersStates
		add: (PlayerState onPosition: netNewPosition onLapNumber: newLapNumber)

	"(board spotAt: netNewPosition) applyEffectOn: self triggeredBy: player"
]

{ #category : #accessing }
GameState >> players [
	^ playerStates keys asOrderedCollection
]

{ #category : #accessing }
GameState >> positionOfPlayer: player [
	^ (playerStates
		at: player
		ifAbsent: [ AssertionFailure
				signal: 'Asked for the position of a player that is not in game' ])
		last position
]
