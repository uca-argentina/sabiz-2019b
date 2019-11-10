"
This class represents an instant effect produced by playing a card
"
Class {
	#name : #RepeatEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RepeatEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	| history |
	history := aGame historyOf: aPlayer.
	history size <= 2
		ifTrue: [ ^ self ].
	aGame
		applyEffectTriggeredBy: aPlayer
		in: (history at: history size - 1)
]
