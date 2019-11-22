"
This class represents an instant repeat effect produced by playing a card
"
Class {
	#name : #RepeatEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RepeatEffect >> = anEffect [
	^ self class = anEffect class
]

{ #category : #effect }
RepeatEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	| history |
	history := aGame historyOf: aPlayer.
	self checkIfDicesWereRolledAtLeastOnceIn: history.
	aGame
		player: aPlayer
		triggersEffectAt: (history at: history size - 1) position.
	aGame addPlayedCard: (Card with: self)
]

{ #category : #effect }
RepeatEffect >> checkIfDicesWereRolledAtLeastOnceIn: history [
	history size < 2
		ifTrue: [ AssertionFailure
				signal: 'Cant play that card because the dices never rolled' ]
]
