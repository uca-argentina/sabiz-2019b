"
This class contains tests about boards
"
Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testBoardHasGivenNumberOfSpots [
	self assert: (Board withSpots: 3) numberOfSpots equals: 3
]

{ #category : #tests }
BoardTest >> testBoardInitializesWithAllSpotsEmpty [
	| board |
	board := Board withSpots: 4.
	board spots
		do: [ :spot | self assert: spot quantityOfPlayers equals: 0 ]
]
