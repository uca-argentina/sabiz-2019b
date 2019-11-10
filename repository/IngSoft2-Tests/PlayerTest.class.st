"
This class contains tests about players
"
Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAllPlayerReceivesTwoCardsAsSoonAsHeEntersTheGame [
	| game board |
	board := Board standard.
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: board.
	game players
		do: [ :each | self assert: each cardsInHand size equals: 2 ]
]

{ #category : #tests }
PlayerTest >> testTwoPlayersWithTheDifferentNamesAreTheDifferentPlayers [
	self deny: (Player named: #player1) equals: (Player named: #player2)
]

{ #category : #tests }
PlayerTest >> testTwoPlayersWithTheSameNameAreTheSamePlayer [
	self
		assert: (Player named: #player1)
		equals: (Player named: #player1)
]
