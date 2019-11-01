"
Go back 4 spots
"
Class {
	#name : #WormHoleEffect,
	#superclass : #SpotEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
WormHoleEffect >> applyOn: game triggeredBy: player in: state [
	| newState |
	newState := game
		nextStateFor: state
		afterMoving: self numberOfSpotsToGoBack.
	game set: newState for: player
]

{ #category : #standardValues }
WormHoleEffect >> numberOfSpotsToGoBack [
	^ -4
]
