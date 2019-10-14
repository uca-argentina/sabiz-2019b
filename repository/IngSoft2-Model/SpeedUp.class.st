"
Move forwards 4 spots
"
Class {
	#name : #SpeedUp,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #'standard values' }
SpeedUp class >> probability [
	^ 15
]

{ #category : #effect }
SpeedUp >> applyEffectOn: gameState triggeredBy: player [
	gameState player: player advances: self numberOfSpotsToGoForward
]

{ #category : #effect }
SpeedUp >> numberOfSpotsToGoForward [
	^ 4
]
