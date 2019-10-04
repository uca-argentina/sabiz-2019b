"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board withSpots: 0 ] raise: AssertionFailure;
		should: [ Board withSpots: -1 ] raise: AssertionFailure
]
