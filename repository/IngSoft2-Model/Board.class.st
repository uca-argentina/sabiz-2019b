"
Class that represents a game board with spots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spots',
		'numberOfLaps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Board class >> checkNumberOfSpots: spotsAmmount checkNumberOfLaps: numberOfLaps [
	self
		assert: [ spotsAmmount > 0 ]
		description: 'Invalid number of spots'.
	self
		assert: [ numberOfLaps > 0 ]
		description: 'Invalid number of laps'
]

{ #category : #'instance creation' }
Board class >> regularWithSpots: spotsNumber andLaps: lapsNumber [
	^ self
		with: (OrderedCollection new: spotsNumber withAll: (Spot with: NullEffect new))
		andLaps: lapsNumber
]

{ #category : #'instance creation' }
Board class >> standard [
	^ self
		standardWithSpots: self standardNumberOfSpots
		andLaps: self standardNumberOfLaps
]

{ #category : #standardValues }
Board class >> standardEffectDistribution [
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

{ #category : #standardValues }
Board class >> standardNumberOfLaps [
	^ 2
]

{ #category : #standardValues }
Board class >> standardNumberOfSpots [
	^ 10
]

{ #category : #'instance creation' }
Board class >> standardWithSpots: spots andLaps: laps [
	^ self
		with: self standardEffectDistribution
		andSpots: spots
		andLaps: laps
]

{ #category : #'instance creation' }
Board class >> with: spotCollection andLaps: numberOfLaps [
	self
		checkNumberOfSpots: spotCollection size
		checkNumberOfLaps: numberOfLaps.
	^ self new with: spotCollection andLaps: numberOfLaps
]

{ #category : #'instance creation' }
Board class >> with: elementDistribution andSpots: spotsAmount andLaps: numberOfLaps [
	| spots |
	spots := OrderedCollection new.
	spotsAmount
		timesRepeat: [ spots add: (Spot with: elementDistribution random) ].
	^ self with: spots asArray andLaps: numberOfLaps
]

{ #category : #effect }
Board >> applyEffectOn: game triggeredBy: player in: state [
	(self spotAt: state position)
		applyEffectOn: game
		triggeredBy: player
		in: state
]

{ #category : #'private - moving' }
Board >> nextStateFor: state afterMoving: rollSum [
	| newLapNumber netNewPosition grossNewPosition |
	grossNewPosition := state position + rollSum.
	newLapNumber := state lapNumber
		+ (grossNewPosition // self numberOfSpots).
	netNewPosition := grossNewPosition % self numberOfSpots.
	netNewPosition == 0
		ifTrue: [ netNewPosition := self numberOfSpots.
			newLapNumber := newLapNumber - 1 ].
	^ PlayerState
		on: netNewPosition
		and: newLapNumber
		under: state effects
]

{ #category : #accessing }
Board >> numberOfLaps [
	^ numberOfLaps
]

{ #category : #accessing }
Board >> numberOfSpots [
	^ spots size
]

{ #category : #accessing }
Board >> spotAt: position [
	self assert: (position > 0 and: position <= self numberOfSpots).
	^ spots at: position
]

{ #category : #initialization }
Board >> with: spotsCollection andLaps: lapsAmmount [
	spots := spotsCollection.
	numberOfLaps := lapsAmmount
]
