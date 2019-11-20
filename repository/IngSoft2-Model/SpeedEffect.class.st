"
This effect adds 1 to the rollSum of a given player
"
Class {
	#name : #SpeedEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedEffect >> applyEffectOn: player on: aGame triggeredBy: aPlayer [
	self checkTurnOf: aPlayer in: aGame.
	(aGame historyOf: player) last addEffectOfCard: (Card with: self).
	aGame addPlayedCard: (Card with: self)
]

{ #category : #evaluating }
SpeedEffect >> value [
	^ 1
]
