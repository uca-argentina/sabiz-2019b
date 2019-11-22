"
This Object represents a instant redo effect triggered by using a card
"
Class {
	#name : #RedoEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RedoEffect >> = anEffect [
	^ self class = anEffect class
]

{ #category : #effect }
RedoEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	| lastCardPlayed |
	self checkIfOneCardWasPlayesAtLeastin: aGame.
	lastCardPlayed := aGame allCardsPlayed last.
	lastCardPlayed effect
		applyEffectOn: players
		on: aGame
		triggeredBy: aPlayer
]

{ #category : #effect }
RedoEffect >> checkIfOneCardWasPlayesAtLeastin: aGame [
	aGame allCardsPlayed size < 1
		ifTrue: [ AssertionFailure
				signal: 'Cant play that card because no other cards has been played' ]
]
