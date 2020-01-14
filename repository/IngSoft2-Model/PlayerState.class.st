"
This class contains information about the current state of a player, consisting of a lap number, the position of the player in the board, and the list of effects that are applied to him
"
Class {
	#name : #PlayerState,
	#superclass : #Object,
	#instVars : [
		'position',
		'lapNumber',
		'permanentEffects',
		'roundNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerState class >> on: position and: lapNumber [
	"Used to create the first state"
	^ self on: position and: lapNumber and: 1 under: OrderedCollection new
]

{ #category : #'instance creation' }
PlayerState class >> on: position and: lapNumber and: roundNumber under: playerEffects [
	self
		assert: position > 0
		description: 'A player cant be on a position lower than 1'.
	^ self new on: position and: lapNumber and: roundNumber under: playerEffects
]

{ #category : #comparing }
PlayerState >> > aState [
	self lapNumber == aState lapNumber
		ifTrue: [ ^ self position > aState position ]
		ifFalse: [ ^ self lapNumber > aState lapNumber ]
]

{ #category : #adding }
PlayerState >> addEffectOf: aCard [
	permanentEffects add: aCard effect
]

{ #category : #accessing }
PlayerState >> effects [
	^ permanentEffects copy
]

{ #category : #accessing }
PlayerState >> lapNumber [
	^ lapNumber copy
]

{ #category : #initialization }
PlayerState >> on: currentPosition and: currentLapNumber and: currentRoundNumber under: playerEffects [
	position := currentPosition copy.
	lapNumber := currentLapNumber copy.
	permanentEffects := playerEffects.
	roundNumber := currentRoundNumber
]

{ #category : #accessing }
PlayerState >> position [
	^ position copy
]

{ #category : #accessing }
PlayerState >> roundNumber [
	^ roundNumber
]
