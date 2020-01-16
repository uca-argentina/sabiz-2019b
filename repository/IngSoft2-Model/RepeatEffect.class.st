"
This class represents an instant effect produced by playing a card
"
Class {
	#name : #RepeatEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RepeatEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	| history |
	history := aGame historyOf: aPlayer.
	history size < 2
		ifTrue: [ AssertionFailure
				signal: 'Cant play that card because the dices never rolled' ].
	aGame
		player: aPlayer
		triggersEffectAt: (history at: history size - 1) position
]
