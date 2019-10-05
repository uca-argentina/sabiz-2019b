"
This class contains information about the current state of a player
"
Class {
	#name : #PlayerState,
	#superclass : #Object,
	#instVars : [
		'position',
		'lapNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerState class >> onPosition: position onLapNumber: lapNumber [
	^ self new onPosition: position onLapNumber: lapNumber
]

{ #category : #accesing }
PlayerState >> lapNumber [
	^ lapNumber copy
]

{ #category : #initialization }
PlayerState >> onPosition: currentPosition onLapNumber: currentLapNumber [
	position := currentPosition copy.
	lapNumber := currentLapNumber copy
]

{ #category : #accesing }
PlayerState >> position [
	^ position copy
]
