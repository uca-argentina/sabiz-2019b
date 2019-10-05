"
Class that represents a game board with spots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spots',
		'numberOfLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSpots: spotsAmmount andNumberOfLaps: numberOfLaps [
	self
		assert: [ spotsAmmount > 0 ]
		description: 'Invalid number of spots'.
	self
		assert: [ numberOfLaps > 0 ]
		description: 'Invalid number of laps'.
	^ self new
		initializeWithSpots: spotsAmmount
		andNumberOfLaps: numberOfLaps
]

{ #category : #initialization }
Board >> initializeWithSpots: spotsAmmount andNumberOfLaps: lapsAmmount [
	spots := Array new: spotsAmmount withAll: Spot new.
	numberOfLaps := lapsAmmount
]

{ #category : #accessing }
Board >> numberOfLaps [
	^ numberOfLaps
]

{ #category : #accessing }
Board >> numberOfSpots [
	^ spots size
]
