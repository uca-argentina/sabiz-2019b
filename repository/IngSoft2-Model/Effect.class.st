"
A class used to create the effects that can be assigned to a spot
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
Effect >> applyOn: gameState triggeredBy: player [
	self subclassResponsibility
]
