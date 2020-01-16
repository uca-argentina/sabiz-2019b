"
Go back to the starting position of your last turn, if the game just started, just go back to the starting position
"
Class {
	#name : #TimeMachineEffect,
	#superclass : #SpotEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
TimeMachineEffect >> applyOn: game triggeredBy: player [
	game rewindPositionFor: player
]
