"
This class contains tests about player state
"
Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testCantCreateAPositionWithAnInvalidSpotNumber [
	self
		should: [ Position on: 0 and: 1 ]
		raise: AssertionFailure.
	self
		should: [ Position on: -1 and: 1 ]
		raise: AssertionFailure
]

{ #category : #tests }
PositionTest >> testPositionHasGivenLapNumber [
	| position |
	position := Position on: 5 and: 2.
	self assert: position lapNumber equals: 2
]

{ #category : #tests }
PositionTest >> testPositionHasGivenSpotNumber [
	| position |
	position := Position on: 5 and: 2.
	self assert: position spotNumber equals: 5
]
