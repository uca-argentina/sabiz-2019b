"
This class contains tests about spots.
"
Class {
	#name : #SpotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpotTest >> testSpotIgnoresRepeatedPlayers [
	| spot |
	spot := Spot occupiedBy: {#player1 . #player2 . #player1}.
	self assert: spot quantityOfPlayers equals: 2
]

{ #category : #tests }
SpotTest >> testSpotIsEmpty [
	| spot |
	spot := Spot empty.
	self assert: spot quantityOfPlayers equals: 0
]

{ #category : #tests }
SpotTest >> testSpotIsOccupied [
	| spot |
	spot := Spot occupiedBy: {#player1}.
	self assert: spot quantityOfPlayers > 0
]

{ #category : #tests }
SpotTest >> testSpotIsOccupiedByGivenPlayer [
	| spot |
	spot := Spot occupiedBy: {#player1}.
	self assert: (spot players includes: #player1)
]

{ #category : #tests }
SpotTest >> testSpotProhibitsAddingObjectsDifferentThanSymbols [
	self
		should: [ Spot occupiedBy: {'Not a symbol'} ]
		raise: AssertionFailure
]
