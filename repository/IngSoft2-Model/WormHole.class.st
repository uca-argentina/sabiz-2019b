"
Go back 4 spots
"
Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
WormHole >> applyEffectOn: gameState triggeredBy: player [
	gameState player: player advances: self numberOfSpotsToGoBack
]

{ #category : #effect }
WormHole >> numberOfSpotsToGoBack [
	^ -4
]
