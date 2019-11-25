"
This effect adds one to every rollSum
"
Class {
	#name : #AccelerationEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
AccelerationEffect >> = anEffect [
	^ self class = anEffect class
]

{ #category : #effect }
AccelerationEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	self checkTurnOf: aPlayer in: aGame.
	aGame addEffectOfCard: (Card with: self).
	aGame addPlayedCard: (Card with: self)
]

{ #category : #evaluating }
AccelerationEffect >> value [
	^ 1
]
