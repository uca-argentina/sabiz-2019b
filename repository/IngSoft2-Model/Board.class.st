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
Board class >> regularWithNumberOfSpots: spotsNumber andNumberOfLaps: lapsNumber [
	^ self
		withSpotCollection: (OrderedCollection new: spotsNumber withAll: Regular new)
		andNumberOfLaps: lapsNumber
]

{ #category : #'instance creation' }
Board class >> withDistribution: spotDistribution numberOfSpots: spotsAmount andNumberOfLaps: numberOfLaps [
	| spots |
	spots := OrderedCollection new.
	spotsAmount timesRepeat: [ spots add: spotDistribution randomSpot ].
	^ self
		withSpotCollection: spots asArray
		andNumberOfLaps: numberOfLaps
]

{ #category : #'instance creation' }
Board class >> withSpotCollection: spotCollection andNumberOfLaps: numberOfLaps [
	self
		checkNumberOfSpots: spotCollection size
		checkNumberOfLaps: numberOfLaps.
	^ self new
		withSpotCollection: spotCollection
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
Board >> withSpotCollection: spotsCollection andNumberOfLaps: lapsAmmount [
	spots := spotsCollection asArray.
	numberOfLaps := lapsAmmount
]
