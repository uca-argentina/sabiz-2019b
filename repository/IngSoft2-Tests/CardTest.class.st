"
This class contains tests about cards and playerEffects in general
"
Class {
	#name : #CardTest,
	#superclass : #ModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesInOneDicesRollResulForAllPlayers [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {7})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 9.
	self assert: (game positionOf: player2) equals: 9
]

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesInOneDicesRollResulForAllPlayersAndIsAcumulative [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {2})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	cardToPlay := (game cardsInHandOf: player2) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 8.
	self assert: (game positionOf: player2) equals: 5
]

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesInOneDicesRollResult [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {7})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: (AccelerationEffect new).
	cardToPlay := (game cardsInHandOf: player1) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	self assert: (game positionOf: player1) equals: 9
]

{ #category : #'tests - permanent' }
CardTest >> testCantPlayAPermanentCardIfIsNotTheTurnOfThePlayer [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {7})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player2) first.
	self
		should: [ game
				player: player2
				playsCard: cardToPlay
				affecting: 'It is no necessary to clarify, this card affects all players' ]
		raise: AssertionFailure
]

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesInTwoDicesRollResulForOnlyOnePlayerAndIsAcumulative [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {4})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	cardToPlay := (game cardsInHandOf: player2) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 3.
	self assert: (game positionOf: player2) equals: 5
]

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesInTwoDicesRollResultOfOnlyOnePlayer [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {7})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player2.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 8.
	self assert: (game positionOf: player2) equals: 6.
]

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesInTwoDicesRollResultOfOnlyOnePlayerAndIfAcumulativeIsNegativeGoesBack [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {1})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player2.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 2.
	self assert: (game positionOf: player2) equals: 10.
	self assert: (game lapOf: player2) equals: -1.
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
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {1})}
		using: board
		andDeckLoadedWith: RepeatEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game lapOf: player1) equals: 1.
	game
		player: player1
		playsCard: cardToPlay
		affecting:
			'No need to clarify because this effect always applies over the player who plays it'.
	self assert: (game positionOf: player1) equals: 5.
	self assert: (game lapOf: player1) equals: 1
]

{ #category : #'tests - instant' }
CardTest >> testRepeatCardCannotBePlayedIfDicesNeverRolled [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(RandomDice withFaces: 6)}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: RepeatEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	self
		should:
			[ game nextTurnPlaying: cardToPlay affecting: player2 ]
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
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {1})}
		using: board
		andDeckLoadedWith: RepeatEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game lapOf: player1) equals: 1.
	game
		player: player1
		playsCard: cardToPlay
		affecting:
			'No need to clarify because this effect always applies over the player who plays it'.
	self assert: (game positionOf: player1) equals: 5.
	self assert: (game lapOf: player1) equals: 1
]

{ #category : #'tests - permanent' }
CardTest >> testSpeedEffectIncreasesInOneDicesRollResulForOnlyOnePlayerAndIsAcumulative [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {2})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: SpeedEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	cardToPlay := (game cardsInHandOf: player2) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 8.
	self assert: (game positionOf: player2) equals: 3
]

{ #category : #'tests - permanent' }
CardTest >> testSpeedEffectIncreasesInOneDicesRollResultOfOnlyOnePlayer [
	| game cardToPlay |
	game := Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {7})}
		using: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
		andDeckLoadedWith: SpeedEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 9.
	self assert: (game positionOf: player2) equals: 8
]
