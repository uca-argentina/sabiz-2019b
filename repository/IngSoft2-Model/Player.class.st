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
	^self new
		initializeWith: playerIdentificationNumber 
]

{ #category : #'as yet unclassified' }
Player >> initializeWith: playerIdentificationNumber [ 
	identificationNumber := playerIdentificationNumber.
	position := 0
]

{ #category : #accesing }
Player >> position [
	^ position
]
