"
Go back 4 spots
"
Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
WormHoleEffect >> applyOn: gameState triggeredBy: player [
	gameState player: player moves: self numberOfSpotsToGoBack
]

{ #category : #standardValues }
WormHoleEffect >> numberOfSpotsToGoBack [
	^ -4
]
