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
PlayerTest >> testCantPlayACardThatIsNotInTheHand [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: RepeatEffect.
	cardToPlay := Card newWith: AccelerationEffect.
	self
		should: [ game
				player: (Player named: #player1)
				playsCard: cardToPlay
				affecting: (Player named: #player2) ]
		raise: AssertionFailure
]

{ #category : #tests }
PlayerTest >> testPlayingACardRemovesItFromHand [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: (Board regularWithSpots: 10 andLaps: 2).
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game
		player: (Player named: #player1)
		playsCard: cardToPlay
		affecting: (Player named: #player2).
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
