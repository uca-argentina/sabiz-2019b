"
This class contains tests about the players
"
Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> negativeNumbers [
	^ -1
]

{ #category : #tests }
PlayerTest >> testPlayerAdvancesWhenDiceIsRolled [

	| dice player |
	dice := LoadedDice loadedWith: 4.
	player := Player withNumber: 1.
	player advance: (dice roll).
	self assert: player position equals: 5 
]

{ #category : #tests }
PlayerTest >> testPlayerStartsAtPositionOne [

	| player |
	player := Player withNumber: 1.
	self assert: player position equals: 1.
]

{ #category : #tests }
PlayerTest >> testProhibitsCreatingPlayerWithWrongIdentificationNumber [
	self
		should: [ Player withNumber: 0 ] raise: AssertionFailure;
		should: [ Game withSpots: self negativeNumbers ]
			raise: AssertionFailure
]
