"
This class contains tests about cards and playerEffects in general
"
Class {
	#name : #CardTest,
	#superclass : #StandardModelTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #resources }
CardTest >> add: aCard on: aGame to: aPlayer [
	(aGame cardsInHandOf: aPlayer) add: aCard
]

{ #category : #resources }
CardTest >> newCardTestingGameFor: cardEffect [
	^ self
		newCardTestingGameFor: cardEffect
		on: (testResource effectlessBoardWithSpots: 10 andLaps: 2)
]

{ #category : #resources }
CardTest >> newCardTestingGameFor: cardEffect on: board [
	^ Game
		playedBy: {player1. player2}
		throwing: {(SequentialDice withSequence: {1})}
		on: board
		using: (Deck with: {cardEffect})
]

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesByOneRollResults [
	| game cardToPlay |
	game := self newCardTestingGameFor: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	self assert: (game positionOf: player1) equals: 3
]

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesByOneRollResultsForAllPlayers [
	| game cardToPlay |
	game := self newCardTestingGameFor: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 3.
	self assert: (game positionOf: player2) equals: 3
]

{ #category : #'tests - permanent' }
CardTest >> testAccelerationEffectIncreasesByOneRollResultsForAllPlayersAndIsAcumulative [
	| game cardToPlay |
	game := self newCardTestingGameFor: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	cardToPlay := (game cardsInHandOf: player2) first.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 6.
	self assert: (game positionOf: player2) equals: 4
]

{ #category : #'tests - permanent' }
CardTest >> testCantPlayAPermanentCardIfItsNotTheTurnOfThePlayer [
	| game cardToPlay |
	game := self newCardTestingGameFor: AccelerationEffect new.
	cardToPlay := (game cardsInHandOf: player2) first.
	self assert: game currentTurn equals: player1.
	self
		should: [ game
				player: player2
				playsCard: cardToPlay
				affecting: 'It is no necessary to clarify, this card affects all players' ]
		raise: AssertionFailure
]

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesByTwoTheRollResultOfOnlyOnePlayer [
	| game cardToPlay |
	game := self newCardTestingGameFor: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player2.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 2.
	self assert: (game positionOf: player2) equals: 10.
	self assert: (game lapOf: player2) equals: -1
]

{ #category : #'tests - permanent' }
CardTest >> testOverloadEffectDecreasesByTwoTheRollResultOfOnlyOnePlayerAndIsAcumulative [
	| game cardToPlay |
	game := self newCardTestingGameFor: OverloadEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	cardToPlay := (game cardsInHandOf: player2) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 7.
	self assert: (game lapOf: player1) equals: -1.
	self assert: (game positionOf: player2) equals: 2
]

{ #category : #'tests - instant' }
CardTest >> testRedoCardActsAsAPermanentIfLastPlayedCardIsPermanent [
	| game cardToPlay board |
	board := testResource
		effectTestingBoardWithSpots: 5
		and: SpeedUpEffect new
		at: 2.
	game := self newCardTestingGameFor: AccelerationEffect new on: board.
	cardToPlay := (game cardsInHandOf: player1) first.
	self add: (Card with: RedoEffect new) on: game to: player1.
	game
		nextTurnPlaying: cardToPlay
		affecting: 'It is no necessary to clarify, this card affects all players'.
	game nextTurnWithoutPlayingCards.
	cardToPlay := (game cardsInHandOf: player1) last.
	self
		should: [ game player: player1 playsCard: cardToPlay affecting: game players ]
		raise: AssertionFailure
		whoseDescriptionIncludes: 'Is not the turn of that player, cannot play permanent cards'
		description: 'description incorrect'
]

{ #category : #'tests - instant' }
CardTest >> testRedoCardActsAsAnInstantIfLastPlayedCardIsInstant [
	| game cardToPlay board |
	board := testResource
		effectTestingBoardWithSpots: 5
		and: SpeedUpEffect new
		at: 2.
	game := self newCardTestingGameFor: RepeatEffect new on: board.
	cardToPlay := (game cardsInHandOf: player1) first.
	self add: (Card with: RedoEffect new) on: game to: player1.
	game nextTurnWithoutPlayingCards.
	game
		player: player1
		playsCard: cardToPlay
		affecting:
			'No need to clarify because this effect always applies over the player who plays it'.
	game nextTurnWithoutPlayingCards.
	cardToPlay := (game cardsInHandOf: player1) last.
	self assert: game currentTurn equals: player2.
	self
		shouldnt: [ game
				player: player1
				playsCard: cardToPlay
				affecting:
					'No need to clarify because this effect always applies over the player who plays it' ]
		raise: AssertionFailure
]

{ #category : #'tests - instant' }
CardTest >> testRepeatCardCanBePlayedEvenIfItIsNotTheTurnOfThePlayer [
	| game cardToPlay board |
	board := testResource
		effectTestingBoardWithSpots: 5
		and: SpeedUpEffect new
		at: 2.
	game := self newCardTestingGameFor: RepeatEffect new on: board.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnWithoutPlayingCards.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 1.
	self assert: (game lapOf: player1) equals: 1.
	self assert: game currentTurn equals: player2.
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
	game := self newCardTestingGameFor: RepeatEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	self
		should:
			[ game nextTurnPlaying: cardToPlay affecting: player2 ]
		raise: AssertionFailure
]

{ #category : #'tests - instant' }
CardTest >> testRepeatCardRepeatesTheEffectOfTheSpotReachedAfterRollingDices [
	| game cardToPlay board |
	board := testResource
		effectTestingBoardWithSpots: 5
		and: SpeedUpEffect new
		at: 2.
	game := self newCardTestingGameFor: RepeatEffect new on: board.
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
CardTest >> testSpeedEffectIncreasesByOneTheRollResulOfOnlyOnePlayerAndIsAcumulative [
	| game cardToPlay |
	game := self newCardTestingGameFor: SpeedEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	cardToPlay := (game cardsInHandOf: player2) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 6.
	self assert: (game positionOf: player2) equals: 2
]

{ #category : #'tests - permanent' }
CardTest >> testSpeedEffectIncreasesByOneTheRollResultOfOnlyOnePlayer [
	| game cardToPlay |
	game := self newCardTestingGameFor: SpeedEffect new.
	cardToPlay := (game cardsInHandOf: player1) first.
	game nextTurnPlaying: cardToPlay affecting: player1.
	game nextTurnWithoutPlayingCards.
	self assert: (game positionOf: player1) equals: 3.
	self assert: (game positionOf: player2) equals: 2
]
