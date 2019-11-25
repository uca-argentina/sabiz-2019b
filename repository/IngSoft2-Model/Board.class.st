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
Board class >> newWith: numberOfSpots and: numberOfLaps [
	| spots |
	self
		checkNumberOfSpots: numberOfSpots
		checkNumberOfLaps: numberOfLaps.
	spots := OrderedCollection new.
	numberOfSpots
		timesRepeat: [ spots add: (Spot with: self standardEffectDistribution random) ].
	^ Board new initializeWith: spots andLaps: numberOfLaps
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

{ #category : #effect }
Board >> applyEffectOn: game triggeredBy: player in: state [
	(self spotAt: state position)
		applyEffectOn: game
		triggeredBy: player
		in: state
]

{ #category : #initialization }
Board >> initializeWith: spotsCollection andLaps: lapsAmmount [
	spots := spotsCollection.
	numberOfLaps := lapsAmmount
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

{ #category : #effect }
Board >> player: aPlayer triggersEffectAt: aPosition on: aGame [
	| lastState |
	lastState := (aGame historyOf: aPlayer) last.
	(self spotAt: aPosition)
		applyEffectOn: aGame
		triggeredBy: aPlayer
		in: lastState
]

{ #category : #accessing }
Board >> spotAt: position [
	self assert: (position > 0 and: position <= self numberOfSpots).
	^ spots at: position
]
