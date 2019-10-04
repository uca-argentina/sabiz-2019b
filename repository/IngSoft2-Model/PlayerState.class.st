"
This class contains information about the current state of a player
"
Class {
	#name : #PlayerState,
	#superclass : #Object,
	#instVars : [
		'position',
		'rowNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerState class >> onPosition: position onRowNumber: rowNumber [
	^ self new onPosition: position onRowNumber: rowNumber
]

{ #category : #initialization }
PlayerState >> onPosition: currentPosition onRowNumber: currentRowNumber [
	position := currentPosition copy.
	rowNumber := currentRowNumber copy
]

{ #category : #accesing }
PlayerState >> position [
	^ position copy
]

{ #category : #accesing }
PlayerState >> rowNumber [
	^ rowNumber copy
]
