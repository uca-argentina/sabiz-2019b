"
A regular spot with no effect
"
Class {
	#name : #Regular,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
Regular >> applyEffectOn: gameState triggeredBy: player [
	self isDummy
]

{ #category : #dummy }
Regular >> isDummy [
	^ true
]
