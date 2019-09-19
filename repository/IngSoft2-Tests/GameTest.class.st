Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> negativeNumberOfSpots [
	^ -1
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfPlayers [
]

{ #category : #tests }
GameTest >> testGameHasGivenNumberOfSpots [
	| board |
	board := Game withSpots: 20.
	self assert: board numberOfSpots equals: 20
]

{ #category : #tests }
GameTest >> testGameHasGivenPlayer [
]

{ #category : #tests }
GameTest >> testGameHasGivenSetOfDices [
]

{ #category : #tests }
GameTest >> testGameIsOverWhenSomeoneWins [
]

{ #category : #tests }
GameTest >> testPlayerOneWonTheGame [
]

{ #category : #tests }
GameTest >> testProhibitsCreatingGameWithInvalidNumberOfSpots [
	self
		should: [ Game withSpots: 0 ] raise: Error;
		should: [ Game withSpots: self negativeNumberOfSpots ]
			raise: Error
]

{ #category : #tests }
GameTest >> testRiggedGameEndsAsExpected [
]
