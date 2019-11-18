"
This class contains tests about players
"
Class {
	#name : #PlayerTest,
	#superclass : #ModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAllPlayerReceivesTwoCardsAsSoonAsHeEntersTheGame [
	| game board |
	board := testResource standardBoard.
	game := Game
		playedBy: {player1. player2}
		throwing: {RandomDice withFaces: 6}
		using: board.
	game players
		do: [ :each | self assert: each cardsInHand size equals: 2 ]
]

{ #category : #tests }
PlayerTest >> testCantPlayACardThatIsNotInTheHand [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: RepeatEffect new.
	cardToPlay := Card newWith: AccelerationEffect new.
	self
		should:
			[ game nextTurnPlaying: cardToPlay affecting: player2 ]
		raise: AssertionFailure
]

{ #category : #tests }
PlayerTest >> testPlayingACardRemovesItFromHand [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player2.
	self
		assert: (game cardsInHandOf: (Player named: #player1)) size
		equals: 1
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
