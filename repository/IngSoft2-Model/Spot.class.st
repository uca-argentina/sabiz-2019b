"
A class used to create the board spots of the game
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
Spot >> applyEffectOn: gameState triggeredBy: player [
	self subclassResponsibility
]
