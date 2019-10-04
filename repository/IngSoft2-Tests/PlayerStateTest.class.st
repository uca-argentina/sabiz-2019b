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
	state := PlayerState onPosition: OrderedCollection new onRowNumber: OrderedCollection new.
	dummy := state position.
	dummy add: 'this tries to change the state by modifying a reference to its attributes'.
	dummy := state rowNumber.
	dummy add: 'this tries to change the state by modifying a reference to its attributes'.
	self assert: state position isEmpty.
	self assert: state rowNumber isEmpty.
]

{ #category : #tests }
PlayerStateTest >> testPlayerStateShowsGivenPosition [
	| state |
	state := PlayerState onPosition: 5 onRowNumber: 2.
	self assert: state rowNumber equals: 2
]

{ #category : #tests }
PlayerStateTest >> testPlayerStateShowsGivenRowNumber [
	| state |
	state := PlayerState onPosition: 5 onRowNumber: 2.
	self assert: state position equals: 5
]

{ #category : #tests }
PlayerStateTest >> testStateAttributesAreInstantiatedByValueAndNotByReference [
	| state dummy |
	dummy := OrderedCollection new.
	state := PlayerState onPosition: dummy onRowNumber: dummy.
	dummy add: 'this tries to change the state by modifying a reference to its attributes'.
	self assert: state position isEmpty.
	self assert: state rowNumber isEmpty.
]
