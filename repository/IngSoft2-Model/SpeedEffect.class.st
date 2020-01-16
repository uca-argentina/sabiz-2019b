"
This effect adds 1 to the rollSum of a given player
"
Class {
	#name : #SpeedEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	super applyOn: target on: aGame triggeredBy: aPlayer.
	self assert: target size = 1 description: 'Tried to play speedup card on more than one player'.
	aGame addPlayedCard: (Card with: self) to: target by: aPlayer
]

{ #category : #accesing }
SpeedEffect >> value [
	^ 1
]
