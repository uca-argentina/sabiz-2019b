"
This effect adds 1 to the rollSum of a given player
"
Class {
	#name : #SpeedEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	self checkTurnOf: aPlayer in: aGame
]

{ #category : #evaluating }
SpeedEffect >> value [
	^ 1
]
