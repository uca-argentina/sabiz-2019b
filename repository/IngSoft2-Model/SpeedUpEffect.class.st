"
Move forwards 4 spots
"
Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUpEffect >> applyOn: game triggeredBy: player in: state [
	| newState |
	newState := game
		nextStateFor: state
		afterMoving: self numberOfSpotsToGoForward.
	game set: newState for: player
]

{ #category : #standardValues }
SpeedUpEffect >> numberOfSpotsToGoForward [
	^ 4
]
