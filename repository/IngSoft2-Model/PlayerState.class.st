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
PlayerState class >> on: position and: lapNumber [
	self assert: position > 0.
	^ self new on: position and: lapNumber
]

{ #category : #accesing }
PlayerState >> lapNumber [
	^ lapNumber copy
]

{ #category : #initialization }
PlayerState >> on: currentPosition and: currentLapNumber [
	position := currentPosition copy.
	lapNumber := currentLapNumber copy
]

{ #category : #accesing }
PlayerState >> position [
	^ position copy
]
