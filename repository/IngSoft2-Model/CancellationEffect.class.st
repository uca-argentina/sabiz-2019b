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
		ifTrue: [ self cancelGlobal: effectToEliminate on: aGame ]
		ifFalse: [ self cancelLocal: effectToEliminate on: players ]
]

{ #category : #effect }
CancellationEffect >> cancelGlobal: aGlobalEffect on: aGame [
]

{ #category : #effect }
CancellationEffect >> cancelLocal: aLocalEffect on: aPlayer [
]

{ #category : #effect }
CancellationEffect >> checkValidPlayers: players of: aGame [
	self
		assert:
			[ (aGame players = players) or: players size = 1 ]
		description: 'This card only affects just one player or all players'
]

{ #category : #accessing }
CancellationEffect >> effectToEliminate [
	^ effectToEliminate
]
