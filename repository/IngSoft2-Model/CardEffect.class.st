"
An abstract superclass to model card effects
"
Class {
	#name : #CardEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CardEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	self subclassResponsibility
]
