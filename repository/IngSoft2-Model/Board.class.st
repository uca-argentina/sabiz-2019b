"
Class that represents a game board with spots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSpots: spotsAmmount [
	self
		assert: [ spotsAmmount > 0 ]
		description: 'Invalid number of spots'.
	^ self new initializeWithSpots: spotsAmmount
]

{ #category : #initialization }
Board >> initializeWithSpots: spotsAmmount [
	spots := Array new: spotsAmmount withAll: Spot new.
]

{ #category : #accessing }
Board >> numberOfSpots [
	^ spots size
]
