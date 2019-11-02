"
This class contains information about the current state of a player, consisting of a lap number, the position of the player in the board, and the list of effects that are applied to him
"
Class {
	#name : #PlayerState,
	#superclass : #Object,
	#instVars : [
		'position',
		'lapNumber',
		'board',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerState class >> on: position and: lapNumber [
	^ self on: position and: lapNumber under: OrderedCollection new
]

{ #category : #'instance creation' }
PlayerState class >> on: position and: lapNumber under: playerEffects [
	self
		assert: position > 0
		description: 'A player cant be on a position lower than 1'.
	^ self new on: position and: lapNumber under: playerEffects
]

{ #category : #comparing }
PlayerState >> > aState [
	self lapNumber == aState lapNumber
		ifTrue: [ ^ self position > aState position ]
		ifFalse: [ ^ self lapNumber > aState lapNumber ]
]

{ #category : #accessing }
PlayerState >> effects [
	^ effects copy
]

{ #category : #accessing }
PlayerState >> lapNumber [
	^ lapNumber copy
]

{ #category : #initialization }
PlayerState >> on: currentPosition and: currentLapNumber under: playerEffects [
	position := currentPosition copy.
	lapNumber := currentLapNumber copy.
	effects := playerEffects
]

{ #category : #accessing }
PlayerState >> position [
	^ position copy
]
