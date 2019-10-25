"
This class represents a spot on a board
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Spot class >> with: anEffect [
	^ self new with: anEffect
]

{ #category : #effect }
Spot >> applyEffectOn: gameState triggeredBy: player [
	^ effect applyOn: gameState triggeredBy: player
]

{ #category : #accessing }
Spot >> effect [
	^ effect
]

{ #category : #'instance creation' }
Spot >> with: anEffect [
	effect := anEffect
]
