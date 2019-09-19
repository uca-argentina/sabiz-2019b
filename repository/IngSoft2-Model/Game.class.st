"
A game with a given number of spots
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'numberOfSpots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withSpots: numberOfSpots [
	self assert: numberOfSpots > 0 description: 'Number of spots invalid'.
	^self new
		initializeWith: numberOfSpots

]

{ #category : #initialization }
Game >> initializeWith: spotAmount [
	numberOfSpots := spotAmount.
]

{ #category : #accessing }
Game >> numberOfSpots [
	^numberOfSpots
]
