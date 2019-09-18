"
A board with a given number of spots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSpots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSpots: numberOfSpots [
	self assert: numberOfSpots > 0 description: 'Number of spots invalid'.
	^self new
		initializeWith: numberOfSpots

]

{ #category : #initialization }
Board >> initializeWith: spotAmount [
	numberOfSpots := spotAmount.
]

{ #category : #accessing }
Board >> numberOfSpots [
	^numberOfSpots
]
