"
Go back 4 spots
"
Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
WormHole >> applyOn: gameState triggeredBy: player [
	gameState move: player
]

{ #category : #standardValues }
WormHole >> numberOfSpotsToGoBack [
	^ -4
]
