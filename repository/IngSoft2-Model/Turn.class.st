"
This class represents the turn handler of the game. It can give the game the information about which player has to play next
"
Class {
	#name : #Turn,
	#superclass : #Object,
	#instVars : [
		'playerSequence',
		'lastPlayerIndex',
		'currentTurn'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Turn class >> newWith: players [
^ self new initializeWith: players.
]

{ #category : #accessing }
Turn >> currentTurn [
	(currentTurn = 0)
		ifTrue: [ ^ playerSequence at: 1 ].
	currentTurn := playerSequence at: lastPlayerIndex + 1.
	^ currentTurn
]

{ #category : #initialization }
Turn >> initializeWith: players [
	playerSequence := players copy.
	lastPlayerIndex := players size - 1.
	currentTurn := 0
]

{ #category : #accessing }
Turn >> nextTurnWithoutPlayingCards [
	lastPlayerIndex := (lastPlayerIndex + 1) % playerSequence size.
	currentTurn := lastPlayerIndex + 1.
	^ playerSequence at: currentTurn
]
