"
A class used to create the board spots of the game
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Spot class >> random [
	self assert: false description: 'Need to implement this!'
]

{ #category : #effect }
Spot >> applyEffecton: gameState triggeredBy: player [
	self subclassResponsibility
]