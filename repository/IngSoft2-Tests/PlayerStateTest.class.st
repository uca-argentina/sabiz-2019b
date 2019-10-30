"
This class contains tests about player state
"
Class {
	#name : #PlayerStateTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerStateTest >> testCantModifyStatesAttributes [
	| state dummy |
	state := PlayerState
		on: OrderedCollection new
		and: OrderedCollection new
		and: nil.
	dummy := state position.
	dummy
		add:
			'this tries to change the state by modifying a reference to its attributes'.
	dummy := state lapNumber.
	dummy
		add:
			'this tries to change the state by modifying a reference to its attributes'.
	self assert: [ state position isEmpty ].
	self assert: [ state lapNumber isEmpty ]
]

{ #category : #tests }
PlayerStateTest >> testPlayerStateShowsGivenLapNumber [
	| state |
	state := PlayerState on: 5 and: 2 and: nil.
	self assert: [ state lapNumber = 2 ]
]

{ #category : #tests }
PlayerStateTest >> testPlayerStateShowsGivenPosition [
	| state |
	state := PlayerState on: 5 and: 2 and: nil.
	self assert: [ state position = 5 ]
]

{ #category : #tests }
PlayerStateTest >> testStateAttributesAreInstantiatedByValueAndNotByReference [
	| state dummy |
	dummy := OrderedCollection new.
	state := PlayerState on: dummy and: dummy and: nil.
	dummy
		add:
			'this tries to change the state by modifying a reference to its attributes'.
	self assert: [ state position isEmpty ].
	self assert: [ state lapNumber isEmpty ]
]
