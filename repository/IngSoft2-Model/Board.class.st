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
Board class >> regularWithSpots: spotsNumber andLaps: lapsNumber [
	^ self
		with: (OrderedCollection new: spotsNumber withAll: (Spot with: Regular new))
		andLaps: lapsNumber
]

{ #category : #'instance creation' }
Board class >> standard [
	^ self
		with: OverallEffectDistribution standard
		andSpots: self standardNumberOfSpots
		andLaps: self standardNumberOfLaps
]

{ #category : #standardValues }
Board class >> standardNumberOfLaps [
	^ 2
]

{ #category : #standardValues }
Board class >> standardNumberOfSpots [
	^ 10
]

{ #category : #'instance creation' }
Board class >> with: spotCollection andLaps: numberOfLaps [
	self
		checkNumberOfSpots: spotCollection size
		checkNumberOfLaps: numberOfLaps.
	^ self new with: spotCollection andLaps: numberOfLaps
]

{ #category : #'instance creation' }
Board class >> with: spotDistribution andSpots: spotsAmount andLaps: numberOfLaps [
	| spots |
	spots := OrderedCollection new.
	spotsAmount timesRepeat: [ spots add: spotDistribution spotWithRandomEffect ].
	^ self
		with: spots asArray
		andLaps: numberOfLaps
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

{ #category : #initialization }
Board >> with: spotsCollection andLaps: lapsAmmount [
	spots := spotsCollection.
	numberOfLaps := lapsAmmount
]
