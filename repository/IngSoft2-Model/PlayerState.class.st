"
This class contains information about the current state of a player
"
Class {
	#name : #PlayerState,
	#superclass : #Object,
	#instVars : [
		'position',
		'lapNumber',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerState class >> on: position and: lapNumber and: board [
	^ self new on: position and: lapNumber and: board
]

{ #category : #accesing }
PlayerState >> lapNumber [
	^ lapNumber copy
]

{ #category : #'private - moving' }
PlayerState >> move: rollSum [
	| newLapNumber netNewPosition grossNewPosition |
	grossNewPosition := position + rollSum.
	newLapNumber := lapNumber + (grossNewPosition // board numberOfSpots).
	netNewPosition := grossNewPosition % board numberOfSpots.
	netNewPosition = 0
		ifTrue: [ netNewPosition := board numberOfSpots.
			newLapNumber := newLapNumber - 1 ].
	position := netNewPosition.
	lapNumber := newLapNumber
]

{ #category : #initialization }
PlayerState >> on: currentPosition and: currentLapNumber and: gameBoard [
	board := gameBoard copy.
	position := currentPosition copy.
	lapNumber := currentLapNumber copy
]

{ #category : #accesing }
PlayerState >> position [
	^ position copy
]
