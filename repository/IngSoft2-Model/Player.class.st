"
A potential player for the game
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'identificationNumber',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> withNumber: playerIdentificationNumber [ 
	self assert: playerIdentificationNumber > 0 description: 'Invalid Identification number'.
	^self new initializeWith: playerIdentificationNumber 
]

{ #category : #playing }
Player >> advance: numberOfSpotsToAdvance [ 
	position := (self position) + numberOfSpotsToAdvance 
]

{ #category : #accessing }
Player >> identificationNumber [
	^ identificationNumber
]

{ #category : #initialization }
Player >> initializeWith: playerIdentificationNumber [ 
	identificationNumber := playerIdentificationNumber.
	position := 1
]

{ #category : #accessing }
Player >> position [
	^ position
]
