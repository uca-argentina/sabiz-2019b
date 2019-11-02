"
Move forwards 4 spots
"
Class {
	#name : #SpeedUpEffect,
	#superclass : #SpotEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUpEffect >> applyOn: game triggeredBy: player in: state [
	| newState |
	newState := game
		nextStateFor: state
		afterMoving: self numberOfSpotsToGoForward.
	game updateStateFor: player with: newState
]

{ #category : #standardValues }
SpeedUpEffect >> numberOfSpotsToGoForward [
	^ 4
]
