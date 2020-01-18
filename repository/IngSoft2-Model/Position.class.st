"
This models the spot number and lap number of a player
"
Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'spotNumber',
		'lapNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Position class >> checkSpotNumber: spotNumber [
	self assert: spotNumber > 0 description: 'The spot number must be a positive integer'
]

{ #category : #'instance creation' }
Position class >> on: spotNumber and: lapNumber [
	self checkSpotNumber: spotNumber.
	^ self new initializeWith: spotNumber and: lapNumber.
]

{ #category : #comparing }
Position >> > aPosition [
	self lapNumber == aPosition lapNumber
		ifTrue: [ ^ self spotNumber > aPosition spotNumber ]
		ifFalse: [ ^ self lapNumber > aPosition lapNumber ]
]

{ #category : #initialization }
Position >> initializeWith: aSpotNumber and: aLapNumber [
	spotNumber := aSpotNumber.
	lapNumber := aLapNumber
]

{ #category : #accessing }
Position >> lapNumber [
	^ lapNumber
]

{ #category : #accessing }
Position >> spotNumber [
	^ spotNumber
]
