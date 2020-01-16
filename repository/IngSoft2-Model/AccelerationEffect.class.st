"
This effect adds one to every rollSum
"
Class {
	#name : #AccelerationEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AccelerationEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	super applyOn: target on: aGame triggeredBy: aPlayer.
	self assert: target = aGame players description: 'Tried to play acceleration card on a specific set of players instead of all of them'.
	aGame addPlayedCard: (Card with: self) to: target by: aPlayer
]

{ #category : #accesing }
AccelerationEffect >> value [
	^ 1
]
