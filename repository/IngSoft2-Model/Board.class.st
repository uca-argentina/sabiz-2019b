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
Board class >> checkNumberOfSpots: spotsAmmount checkNumberOfLaps: numberOfLaps [
	self
		assert: [ spotsAmmount > 0 ]
		description: 'Invalid number of spots'.
	self
		assert: [ numberOfLaps > 0 ]
		description: 'Invalid number of laps'
]

{ #category : #'instance creation' }
Board class >> standardWithNumberOfSpots: spotsAmmount andNumberOfLaps: numberOfLaps [
	| spots |
	spots := OrderedCollection new.
	spotsAmmount timesRepeat: [ spots add: Spot random ].
	^ self
		withSpotsCollection: spots asArray
		andNumberOfLaps: numberOfLaps
]

{ #category : #'instance creation' }
Board class >> withSpotsCollection: spotCollection andNumberOfLaps: numberOfLaps [
	self
		checkNumberOfSpots: spotCollection size
		checkNumberOfLaps: numberOfLaps.
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

{ #category : #'private - accessing' }
Board >> spotAt: position [
	^ spots at: position
]

{ #category : #accessing }
Board >> spots [
	^ spots copy
]

{ #category : #initialization }
Board >> withSpotsCollection: spotsCollection andNumberOfLaps: lapsAmmount [
	spots := spotsCollection asArray.
	numberOfLaps := lapsAmmount
]
