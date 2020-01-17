"
This class contains tests about players
"
Class {
	#name : #PlayerTest,
	#superclass : #StandardModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCantPlayACardThatIsNotInTheHand [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		on: (testResource effectlessBoardWithSpots: 10)
		using: (Deck with: {RepeatEffect new}).
	cardToPlay := Card with: OverloadEffect new.
	self
		should: [ game play: cardToPlay for: player1 on: player2]	 raise: AssertionFailure.
]

{ #category : #tests }
PlayerTest >> testPlayingACardRemovesItFromHand [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		on: (testResource effectlessBoardWithSpots: 10)
		using: (Deck with: {AccelerationEffect new}).
	cardToPlay := (game cardsInHandOf: player1) first.
	game play: cardToPlay for: player1 on: game players. 
	self assert: (game cardsInHandOf: player1) size equals: 1
]

{ #category : #tests }
PlayerTest >> testTwoPlayersWithTheDifferentNamesAreTheDifferentPlayers [
	self deny: (Player named: #player1) equals: (Player named: #player2)
]

{ #category : #tests }
PlayerTest >> testTwoPlayersWithTheSameNameAreTheSamePlayer [
	self assert: (Player named: #player1) equals: (Player named: #player1)
]
