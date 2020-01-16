"
This class models an instant effect that can be applied in the game by using a card
"
Class {
	#name : #CardInstantEffect,
	#superclass : #CardEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CardInstantEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	self subclassResponsibility
]
