"
Resets all players to the starting position, keeping their row number
"
Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AtomicBombEffect >> applyOn: gameState triggeredBy: player [
	gameState moveEveryoneToTheFirstSpot
]
