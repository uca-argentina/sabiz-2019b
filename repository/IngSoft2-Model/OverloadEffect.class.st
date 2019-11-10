"
This effect reduces the rollSum of a given player by 2
"
Class {
	#name : #OverloadEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
OverloadEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	self checkTurnOf: aPlayer in: aGame
]

{ #category : #evaluating }
OverloadEffect >> value [
	^ -2
]
