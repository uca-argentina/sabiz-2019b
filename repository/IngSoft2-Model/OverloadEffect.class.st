"
This effect reduces the rollSum of a given player by 2
"
Class {
	#name : #OverloadEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
OverloadEffect >> = anEffect [
	^ self class = anEffect class
]

{ #category : #effect }
OverloadEffect >> applyEffectOn: player on: aGame triggeredBy: aPlayer [
	self checkTurnOf: aPlayer in: aGame.
	(aGame historyOf: player) last addEffectOfCard: (Card with: self).
	aGame addPlayedCard: (Card with: self)
]

{ #category : #evaluating }
OverloadEffect >> value [
	^ -2
]
