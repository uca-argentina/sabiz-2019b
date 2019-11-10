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
CardTest >> testAccelerationEffectIncreasesInOneDicesRollResulForAllPlayersAndIsAcumulative [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {2})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	cardToPlay := (game cardsInHandOf: (Player named: #player2)) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 8.
	self assert: (game positionOf: (Player named: #player2)) equals: 5
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

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesInTwoDicesRollResulForOnlyOnePlayerAndIsAcumulative [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {4})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game nextTurnPlaying: cardToPlay affecting: (Player named: #player1).
	cardToPlay := (game cardsInHandOf: (Player named: #player2)) first.
	game nextTurnPlaying: cardToPlay affecting: (Player named: #player1).
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 3.
	self assert: (game positionOf: (Player named: #player2)) equals: 5
]

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesInTwoDicesRollResultOfOnlyOnePlayer [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {7})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game nextTurnPlaying: cardToPlay affecting: (Player named: #player2).
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 8.
	self assert: (game positionOf: (Player named: #player2)) equals: 6.
]

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesInTwoDicesRollResultOfOnlyOnePlayerAndIfAcumulativeIsNegativeGoesBack [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {1})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game nextTurnPlaying: cardToPlay affecting: (Player named: #player2).
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 2.
	self assert: (game positionOf: (Player named: #player2)) equals: 10.
	self assert: (game lapOf: (Player named: #player2)) equals: -1.
]

{ #category : #'tests - instant' }
CardTest >> testRepeatCardCanBePlayedEvenIfItIsNotTheTurnOfThePlayer [
	| game cardToPlay board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: SpeedUpEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new)}
		andLaps: 2.
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {1})}
		using: board
		andDeckLoadedWith: RepeatEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 1.
	self assert: (game lapOf: (Player named: #player1)) equals: 1.
	game
		player: (Player named: #player1)
		playsCard: cardToPlay
		affecting:
			'No need to clarify because this effect always applies over the player who plays it'.
	self assert: (game positionOf: (Player named: #player1)) equals: 5.
	self assert: (game lapOf: (Player named: #player1)) equals: 1
]

{ #category : #'tests - instant' }
CardTest >> testRepeatCardCannotBePlayedIfDicesNeverRolled [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(RandomDice withFaces: 6)}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: RepeatEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	self
		should:
			[ game nextTurnPlaying: cardToPlay affecting: (Player named: #player2) ]
		raise: AssertionFailure
]

{ #category : #'tests - instant' }
CardTest >> testRepeatCardRepeatesTheEffectOfTheSpotReachedAfterRollingDices [
	| game cardToPlay board |
	board := Board
		with:
			{(Spot with: NullEffect new).
			(Spot with: SpeedUpEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new).
			(Spot with: NullEffect new)}
		andLaps: 2.
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {1})}
		using: board
		andDeckLoadedWith: RepeatEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 1.
	self assert: (game lapOf: (Player named: #player1)) equals: 1.
	game
		player: (Player named: #player1)
		playsCard: cardToPlay
		affecting:
			'No need to clarify because this effect always applies over the player who plays it'.
	self assert: (game positionOf: (Player named: #player1)) equals: 5.
	self assert: (game lapOf: (Player named: #player1)) equals: 1
]

{ #category : #'tests - permanent' }
CardTest >> testSpeedEffectIncreasesInOneDicesRollResulForOnlyOnePlayerAndIsAcumulative [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {2})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: SpeedEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game nextTurnPlaying: cardToPlay affecting: (Player named: #player1).
	cardToPlay := (game cardsInHandOf: (Player named: #player2)) first.
	game nextTurnPlaying: cardToPlay affecting: (Player named: #player1).
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 8.
	self assert: (game positionOf: (Player named: #player2)) equals: 3
]

{ #category : #'tests - permanent' }
CardTest >> testSpeedEffectIncreasesInOneDicesRollResultOfOnlyOnePlayer [
	| game cardToPlay |
	game := Game
		playedBy:
			{(Player named: #player1).
			(Player named: #player2)}
		throwing: {(SequentialDice withSequence: {7})}
		using: (Board regularWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: SpeedEffect new.
	cardToPlay := (game cardsInHandOf: (Player named: #player1)) first.
	game nextTurnPlaying: cardToPlay affecting: (Player named: #player1).
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: (Player named: #player1)) equals: 9.
	self assert: (game positionOf: (Player named: #player2)) equals: 8
]
