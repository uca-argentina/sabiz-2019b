Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerAdvancesWhenDiceIsRolled [
]

{ #category : #tests }
PlayerTest >> testPlayerHasWon [
]

{ #category : #tests }
PlayerTest >> testPlayerStartsAtPositionZero [
	| player |
	player := Player withNumber: 1.
	self assert: player position equals: 0.
]
