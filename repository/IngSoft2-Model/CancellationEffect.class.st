"
Object that represents a Cancellation effect triggered by playing a card with this effect
"
Class {
	#name : #CancellationEffect,
	#superclass : #CardInstantEffect,
	#instVars : [
		'effectToEliminate'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CancellationEffect >> = anEffect [
	^ self class = anEffect class
]

{ #category : #effect }
CancellationEffect >> applyEffectOn: players on: aGame triggeredBy: aPlayer [
	self checkValidPlayers: players asOrderedCollection of: aGame.
	aGame players = players
		ifTrue: [ self cancelGlobalOn: aGame ]
		ifFalse: [ self cancelLocalEffectOf: players on: aGame ]
]

{ #category : #effect }
CancellationEffect >> cancelGlobalOn: aGame [
	aGame removeEffectOfCard: (Card with: effectToEliminate)
]

{ #category : #effect }
CancellationEffect >> cancelLocalEffectOf: aPlayer on: aGame [
	(aGame historyOf: aPlayer) last
		removeEffectOfCard: (Card with: effectToEliminate)
]

{ #category : #effect }
CancellationEffect >> checkValidPlayers: players of: aGame [
	self
		assert:
			[ (aGame players = players) or: players size = 1 ]
		description: 'This card only affects just one player or all players'
]

{ #category : #initialization }
CancellationEffect >> setEffectToEliminate: aPermanentEffect [
	effectToEliminate := aPermanentEffect
]
