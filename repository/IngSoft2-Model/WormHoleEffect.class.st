"
Go back 4 spots
"
Class {
	#name : #WormHoleEffect,
	#superclass : #SpotEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
WormHoleEffect >> applyOn: game triggeredBy: player [
	game sendBack: player by: self numberOfSpotsToGoBack
]

{ #category : #standardValues }
WormHoleEffect >> numberOfSpotsToGoBack [
	^ -4
]
