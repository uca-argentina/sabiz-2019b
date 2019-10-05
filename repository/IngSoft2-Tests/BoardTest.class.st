"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfLaps [
	self
		should: [ Board withSpots: 10 andNumberOfLaps: 0 ]
			raise: AssertionFailure;
		should: [ Board withSpots: 10 andNumberOfLaps: -1 ]
			raise: AssertionFailure
]

{ #category : #tests }
BoardTest >> testProhibitsCreatingBoardWithInvalidNumberOfSpots [
	self
		should: [ Board withSpots: 0 andNumberOfLaps: 2 ]
			raise: AssertionFailure;
		should: [ Board withSpots: -1 andNumberOfLaps: 2 ]
			raise: AssertionFailure
]
