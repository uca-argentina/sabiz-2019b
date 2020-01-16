"
Spot effect that gives a card to any player that triggers it
"
Class {
	#name : #CardGivingEffect,
	#superclass : #SpotEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CardGivingEffect >> applyOn: game triggeredBy: player [
	game dealCardTo: player
]
