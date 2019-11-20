"
This Object represents a instant redo effect triggered by using a card
"
Class {
	#name : #RedoEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RedoEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	| lastCardPlayed |
	self checkIfOneCardWasPlayesAtLeastin: aGame.
	lastCardPlayed := aGame allCardsPlayed last.
	aGame player: aPlayer playsCard: lastCardPlayed affecting: players
]

{ #category : #effect }
RedoEffect >> checkIfOneCardWasPlayesAtLeastin: aGame [
	aGame allCardsPlayed size < 1
		ifTrue: [ AssertionFailure
				signal: 'Cant play that card because no other cards has been played' ]
]