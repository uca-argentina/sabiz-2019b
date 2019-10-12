"
A regular spot with no effect
"
Class {
	#name : #Empty,
	#superclass : #Spot,
	#category : #'IngSoft2-Model'
}

{ #category : #'standard values' }
Empty class >> probability [
	^ 55
]

{ #category : #effect }
Empty >> applyEffectOn: gameState triggeredBy: player [
	self isDummy
]

{ #category : #dummy }
Empty >> isDummy [
	^ true
]
