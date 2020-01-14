"
This class models a card permanent effects that can be applied to one or more players, and can be accumulated
"
Class {
	#name : #CardPermanentEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CardPermanentEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	self subclassResponsibility
]

{ #category : #effect }
CardPermanentEffect >> checkTurnOf: aPlayer in: aGame [
	self
		assert: [ aGame currentTurn = aPlayer ]
		description: 'Is not the turn of that player, cannot play permanent cards'
]

{ #category : #evaluating }
CardPermanentEffect >> value [
	self subclassResponsibility
]
