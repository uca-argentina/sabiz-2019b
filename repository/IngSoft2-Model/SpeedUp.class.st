"
Move forwards 4 spots
"
Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUp >> applyOn: gameState triggeredBy: player [
	gameState player: player advances: self numberOfSpotsToGoForward
]

{ #category : #effect }
SpeedUp >> numberOfSpotsToGoForward [
	^ 4
]
