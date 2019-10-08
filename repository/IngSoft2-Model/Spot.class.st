"
A class used to create the board spots of the game
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Spot class >> random [
	| dice roll |
	dice := RandomDice withFaces: 100.
	roll := dice roll.
	roll <= 55
		ifTrue: [ ^ Empty new ].
	roll <= 70
		ifTrue: [ ^ SpeedUp new ].
	roll <= 85
		ifTrue: [ ^ WormHole new ].
	roll <= 90
		ifTrue: [ ^ MoonWalk new ].
	roll <= 98
		ifTrue: [ ^ TimeMachine new ].
	^ AtomicBomb new
]

{ #category : #effect }
Spot >> applyEffecton: gameState triggeredBy: player [
	self subclassResponsibility
]
