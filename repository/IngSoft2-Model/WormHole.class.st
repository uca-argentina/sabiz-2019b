"
Go back 4 spots
"
Class {
	#name : #WormHole,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #'standard values' }
WormHole class >> probability [
	^ 15
]

{ #category : #effect }
WormHole >> applyEffectOn: gameState triggeredBy: player [
	gameState player: player advances: self numberOfSpotsGoingBack
]

{ #category : #effect }
WormHole >> numberOfSpotsGoingBack [
	^ -4
]
