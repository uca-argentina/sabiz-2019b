Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> negativeNumberOfSpots [
	^ -1
]

{ #category : #tests }
BoardTest >> testBoardHasGivenNumberOfSpots [
	| board |
	board := Board withSpots: 20.
	self assert: board numberOfSpots equals: 20
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board withSpots: 0 ] raise: Error;
		should: [ Board withSpots: self negativeNumberOfSpots ]
			raise: Error
]
