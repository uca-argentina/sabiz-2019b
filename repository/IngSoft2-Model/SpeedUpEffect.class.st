"
Move forwards 4 spots
"
Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUpEffect >> applyOn: gameState triggeredBy: player [
	gameState player: player moves: self numberOfSpotsToGoForward
]

{ #category : #standardValues }
SpeedUpEffect >> numberOfSpotsToGoForward [
	^ 4
]
