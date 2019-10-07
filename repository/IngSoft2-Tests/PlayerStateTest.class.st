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
		onPosition: OrderedCollection new
		onLapNumber: OrderedCollection new.
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
	state := PlayerState onPosition: 5 onLapNumber: 2.
	self assert: [ state lapNumber = 2 ]
]

{ #category : #tests }
PlayerStateTest >> testPlayerStateShowsGivenPosition [
	| state |
	state := PlayerState onPosition: 5 onLapNumber: 2.
	self assert: [ state position = 5 ]
]

{ #category : #tests }
PlayerStateTest >> testStateAttributesAreInstantiatedByValueAndNotByReference [
	| state dummy |
	dummy := OrderedCollection new.
	state := PlayerState onPosition: dummy onLapNumber: dummy.
	dummy
		add:
			'this tries to change the state by modifying a reference to its attributes'.
	self assert: [ state position isEmpty ].
	self assert: [ state lapNumber isEmpty ]
]
