"
This class generates standard elements with a specific set of characteristics that are going to be needed in order to test each aspect of the model
"
Class {
	#name : #StandardModelTestResource,
	#superclass : #TestResource,
	#category : #'IngSoft2-Tests'
}

{ #category : #boardCreation }
StandardModelTestResource >> boardWith: effectDistribution andSpots: spotsAmount andLaps: numberOfLaps [
	| spots |
	spots := OrderedCollection new.
	spotsAmount
		timesRepeat: [ spots add: (Spot with: effectDistribution random) ].
	^ Board with: spots andLaps: numberOfLaps
]

{ #category : #boardCreation }
StandardModelTestResource >> effectTestingBoardWithSpots: spotsNumber and: effect at: spotNumber [
	| spots |
	spots := OrderedCollection
		new: spotsNumber
		withAll: (Spot with: NullEffect new).
	spots at: spotNumber put: (Spot with: effect).
	^ Board with: spots andLaps: 2
]

{ #category : #boardCreation }
StandardModelTestResource >> effectlessBoardWithSpots: spotsNumber andLaps: lapsNumber [
	^ Board
		with:
			(OrderedCollection
				new: spotsNumber
				withAll: (Spot with: NullEffect new))
		andLaps: lapsNumber
]

{ #category : #boardCreation }
StandardModelTestResource >> standardBoard [
	^ self
		standardBoardWithSpots: self standardNumberOfSpots
		andLaps: self standardNumberOfLaps
]

{ #category : #boardCreation }
StandardModelTestResource >> standardBoardWithSpots: spots andLaps: laps [
	^ self
		boardWith: self standardEffectDistribution
		andSpots: spots
		andLaps: laps
]

{ #category : #standardValues }
StandardModelTestResource >> standardDeckOfCards [
	| cardTypes |
	cardTypes := OrderedCollection new.
	cardTypes
		addAll: (CardInstantEffect subclasses collect: [ :each | each new ]).
	cardTypes
		addAll: (CardPermanentEffect subclasses collect: [ :each | each new ]).
	^ Deck with: cardTypes asArray
]

{ #category : #standardValues }
StandardModelTestResource >> standardEffectDistribution [
	^ OverallOccurrenceDistribution
		with:
			{(IndividualOccurrenceProbability
				of: AtomicBombEffect new
				withProbability: 2).
			(IndividualOccurrenceProbability
				of: NullEffect new
				withProbability: 45).
			(IndividualOccurrenceProbability
				of: MoonWalkEffect new
				withProbability: 5).
			(IndividualOccurrenceProbability
				of: SpeedUpEffect new
				withProbability: 15).
			(IndividualOccurrenceProbability
				of: TimeMachineEffect new
				withProbability: 8).
			(IndividualOccurrenceProbability
				of: WormHoleEffect new
				withProbability: 15).
			(IndividualOccurrenceProbability
				of: CardGivingEffect new
				withProbability: 10)}
]

{ #category : #gameCreation }
StandardModelTestResource >> standardGame [
	^  Game
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
		on: self standardBoard
		using: self standardDeckOfCards
]

{ #category : #standardValues }
StandardModelTestResource >> standardNumberOfLaps [
	^ 2
]

{ #category : #standardValues }
StandardModelTestResource >> standardNumberOfSpots [
	^ 10
]

{ #category : #standardValues }
StandardModelTestResource >> standardSetOfDices [
	^ {(RandomDice withFaces: 6)}
]

{ #category : #standardValues }
StandardModelTestResource >> standardSetOfPlayers [
	^ {(Player named: #player1).
	(Player named: #player2).
	(Player named: #player3)}
]
