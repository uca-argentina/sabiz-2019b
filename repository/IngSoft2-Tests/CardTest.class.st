"
This class contains tests about cards and playerEffects in general
"
Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesInOneDicesRollResulForAllPlayers [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {7})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 9.
	self assert: (game positionOf: (Player named: #player2)) equals: 9
]

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesInOneDicesRollResult [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {7})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: (AccelerationEffect new).
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	self assert: (game positionOf: (Player named: #player1)) equals: 9
]

{ #category : #'tests - permanent' }
CardTest >> testCantPlayAPermanentCardIfIsNotTheTurnOfThePlayer [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {7})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player2)) first.
	self
		should: [ game
				player: (Player named: #player2)
				playsCard: cardToPlay
				affecting: 'It is no necessary to clarify, this card affects all players' ]
		raise: AssertionFailure
]
