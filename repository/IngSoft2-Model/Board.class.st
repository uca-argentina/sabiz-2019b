"
This class represents a game board with spots
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
Board class >> with: spotCollection andLaps: numberOfLaps [
	self
		checkNumberOfSpots: spotCollection size
		checkNumberOfLaps: numberOfLaps.
	^ self new with: spotCollection andLaps: numberOfLaps
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

{ #category : #initialization }
Board >> with: spotsCollection andLaps: lapsAmmount [
	spots := spotsCollection.
	numberOfLaps := lapsAmmount
]
