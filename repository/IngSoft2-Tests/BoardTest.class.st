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
		should: [ Board withSpots: 0 withPlayers: {#player1} ]
			raise: AssertionFailure;
		should: [ Board withSpots: -1 withPlayers: {#player1} ]
			raise: AssertionFailure
]
