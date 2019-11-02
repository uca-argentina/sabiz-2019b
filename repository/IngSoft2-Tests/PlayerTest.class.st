"
This class contains tests about players
"
Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testTwoPlayersWithTheDifferentNamesAreTheDifferentPlayers [
	self
		deny: (Player named: #player1 holding: Card startingSet)
		equals: (Player named: #player2 holding: Card startingSet)
]

{ #category : #tests }
PlayerTest >> testTwoPlayersWithTheSameNameAreTheSamePlayer [
	self
		assert: (Player named: #player1 holding: Card startingSet)
		equals: (Player named: #player1 holding: {Card random})
]
