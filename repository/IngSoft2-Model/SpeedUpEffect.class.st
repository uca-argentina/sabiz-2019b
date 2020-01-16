"
Move forwards 4 spots
"
Class {
	#name : #SpeedUpEffect,
	#superclass : #SpotEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUpEffect >> applyOn: game triggeredBy: player [
	game speedUp: player by: self numberOfSpotsToGoForward
]

{ #category : #standardValues }
SpeedUpEffect >> numberOfSpotsToGoForward [
	^ 4
]
