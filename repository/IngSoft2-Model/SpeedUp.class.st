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
	gameState move: player
]

{ #category : #standardValues }
SpeedUp >> numberOfSpotsToGoForward [
	^ 4
]
