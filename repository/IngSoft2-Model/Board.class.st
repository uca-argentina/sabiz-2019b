"
Class that represents a game board with spots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Board class >> checkNumberOfSpots: spotsAmmount [
	self
		assert: [ spotsAmmount > 0 ]
		description: 'Invalid number of spots'
]

{ #category : #'instance creation' }
Board class >> with: spotCollection [
	self checkNumberOfSpots: spotCollection size.
	^ self new initializeWith: spotCollection
]

{ #category : #'instance creation' }
Board class >> with: effectDistribution andSpots: spotsAmount [
	| spots |
	spots := OrderedCollection new.
	spotsAmount
		timesRepeat: [ spots add: (Spot with: effectDistribution random) ].
	^ Board with: spots
]

{ #category : #effect }
Board >> applyEffectOn: game triggeredBy: player at: position [
	(self spotAt: position) applyEffectOn: game triggeredBy: player
]

{ #category : #initialization }
Board >> initializeWith: spotsCollection [
	spots := spotsCollection.
]

{ #category : #'private - moving' }
Board >> nextStateFor: state afterMoving: rollSum onRoundNumber: roundNumber [
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
		and: roundNumber
		holding: state cardsInHand
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
