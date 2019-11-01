"
This class contains tests about player state
"
Class {
	#name : #PlayerStateTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerStateTest >> testCantCreateAStateWithAnInvalidPosition [
	self should: [ PlayerState on: 0 and: 1 ] raise: AssertionFailure.
	self should: [ PlayerState on: -1 and: 1 ] raise: AssertionFailure
]

{ #category : #tests }
PlayerStateTest >> testPlayerStateShowsGivenLapNumber [
	| state |
	state := PlayerState on: 5 and: 2.
	self assert: [ state lapNumber = 2 ]
]

{ #category : #tests }
PlayerStateTest >> testPlayerStateShowsGivenPosition [
	| state |
	state := PlayerState on: 5 and: 2.
	self assert: [ state position = 5 ]
]
