"
This class generates standard elements with a specific set of characteristics that are going to be needed in order to test each aspect of the model
"
Class {
	#name : #ModelTestResource,
	#superclass : #TestResource,
	#category : #'IngSoft2-Tests'
}

{ #category : #boardCreation }
ModelTestResource >> boardWith: effectDistribution andSpots: spotsAmount andLaps: numberOfLaps [
	| spots |
	spots := OrderedCollection new.
	spotsAmount
		timesRepeat: [ spots add: (Spot with: effectDistribution random) ].
	^ Board with: spots andLaps: numberOfLaps
]

{ #category : #boardCreation }
ModelTestResource >> boardWith: effect at: spotNumber [
]

{ #category : #boardCreation }
ModelTestResource >> effectlessBoardWithSpots: spotsNumber andLaps: lapsNumber [
	^ Board
		with:
			(OrderedCollection
				new: spotsNumber
				withAll: (Spot with: NullEffect new))
		andLaps: lapsNumber
]

{ #category : #boardCreation }
ModelTestResource >> standardBoard [
	^ self
		standardBoardWithSpots: self standardNumberOfSpots
		andLaps: self standardNumberOfLaps
]

{ #category : #boardCreation }
ModelTestResource >> standardBoardWithSpots: spots andLaps: laps [
	^ self
		boardWith: self standardEffectDistribution
		andSpots: spots
		andLaps: laps
]

{ #category : #standardValues }
ModelTestResource >> standardEffectDistribution [
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
ModelTestResource >> standardGame [
	^  Game
		playedBy: self standardSetOfPlayers
		throwing: self standardSetOfDices
		using: self standardBoard
]

{ #category : #standardValues }
ModelTestResource >> standardNumberOfLaps [
	^ 2
]

{ #category : #standardValues }
ModelTestResource >> standardNumberOfSpots [
	^ 10
]

{ #category : #standardValues }
ModelTestResource >> standardSetOfDices [
	^ {(RandomDice withFaces: 6)}
]

{ #category : #standardValues }
ModelTestResource >> standardSetOfPlayers [
	^ {(Player named: #player1).
	(Player named: #player2).
	(Player named: #player3)}
]
