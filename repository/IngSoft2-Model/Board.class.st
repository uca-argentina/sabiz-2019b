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

{ #category : #validation }
Board class >> checkNumberSpots: spotsAmmount checkNumberLaps: numberOfLaps [
	self
		assert: [ spotsAmmount > 0 ]
		description: 'Invalid number of spots'.
	self
		assert: [ numberOfLaps > 0 ]
		description: 'Invalid number of laps'
]

{ #category : #'instance creation' }
Board class >> emptyWithSpots: spotsAmmount andNumberOfLaps: numberOfLaps [
	self checkNumberSpots: spotsAmmount checkNumberLaps: numberOfLaps.
	^ self new
		emptyWithSpots: spotsAmmount
		andNumberOfLaps: numberOfLaps
]

{ #category : #'instance creation' }
Board class >> standardWithSpots: spotsAmmount andNumberOfLaps: numberOfLaps [
	self checkNumberSpots: spotsAmmount checkNumberLaps: numberOfLaps.
	^ self new
		standardWithSpots: spotsAmmount
		andNumberOfLaps: numberOfLaps
]

{ #category : #initialization }
Board >> emptyWithSpots: spotsAmmount andNumberOfLaps: lapsAmmount [
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

{ #category : #initialization }
Board >> standardWithSpots: spotsAmmount andNumberOfLaps: lapsAmmount [
	spots := Array new: spotsAmmount withAll: Spot new.
	numberOfLaps := lapsAmmount
]
