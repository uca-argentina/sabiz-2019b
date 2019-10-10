"
Resets all players to the starting position, keeping their row number
"
Class {
	#name : #AtomicBomb,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #'standard values' }
AtomicBomb class >> probability [
	^ 2
]

{ #category : #effect }
AtomicBomb >> applyEffectOn: gameState triggeredBy: player [
]
