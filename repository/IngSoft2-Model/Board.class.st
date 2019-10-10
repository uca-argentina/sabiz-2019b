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
Board class >> standardWithSpots: spotsAmmount andNumberOfLaps: numberOfLaps [
	self checkNumberSpots: spotsAmmount checkNumberLaps: numberOfLaps.
	^ self new
		standardWithSpots: spotsAmmount
		andNumberOfLaps: numberOfLaps
]

{ #category : #'instance creation' }
Board class >> withSpotsCollection: spotCollection andNumberOfLaps: numberOfLaps [
	self
		checkNumberSpots: spotCollection size
		checkNumberLaps: numberOfLaps.
	^ self new
		withSpotsCollection: spotCollection
		andNumberOfLaps: numberOfLaps
]

{ #category : #accessing }
Board >> numberOfLaps [
	^ numberOfLaps
]

{ #category : #accessing }
Board >> numberOfSpots [
	^ spots size
]

{ #category : #accessing }
Board >> spotAt: position [
	^ spots at: position
]

{ #category : #accessing }
Board >> spots [
	^ spots copy
]

{ #category : #initialization }
Board >> standardWithSpots: spotsAmmount andNumberOfLaps: lapsAmmount [
	| array |
	array := OrderedCollection new.
	spotsAmmount timesRepeat: [ array add: Spot random ].
	spots := array asArray.
	numberOfLaps := lapsAmmount
]

{ #category : #initialization }
Board >> withSpotsCollection: spotsCollection andNumberOfLaps: lapsAmmount [
	spots := spotsCollection asArray.
	numberOfLaps := lapsAmmount
]
