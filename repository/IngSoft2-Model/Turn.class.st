"
This class represents the turn handler of the game. It can give the game the information about which player has to play next and which player is playing now
"
Class {
	#name : #Turn,
	#superclass : #Object,
	#instVars : [
		'playerSequence',
		'lastPlayerIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Turn class >> newWith: players [
^ self new initializeWith: players.
]

{ #category : #accessing }
Turn >> currentTurn [
	^ playerSequence at: lastPlayerIndex + 1
]

{ #category : #initialization }
Turn >> initializeWith: players [
	playerSequence := players copy.
	lastPlayerIndex := players size - 1
]

{ #category : #accessing }
Turn >> nextTurn [
	lastPlayerIndex := (lastPlayerIndex + 1) % playerSequence size.
	^ playerSequence at: lastPlayerIndex + 1
]
