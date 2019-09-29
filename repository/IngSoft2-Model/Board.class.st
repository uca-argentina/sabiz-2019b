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

{ #category : #initialization }
Board class >> withSpots: spotsAmmount [
	self assert: spotsAmmount > 0 description: 'Number of spots invalid'.
	^ self new initializeWithSpots: spotsAmmount
]

{ #category : #initialization }
Board >> initializeWithSpots: spotsAmmount [
	spots := Array  new: spotsAmmount  withAll: Spot empty
]

{ #category : #accessing }
Board >> numberOfSpots [
	^ spots size 
]

{ #category : #accessing }
Board >> spots [
	^ spots
]
