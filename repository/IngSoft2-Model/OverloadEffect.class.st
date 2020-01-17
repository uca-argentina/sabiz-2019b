"
This effect reduces the rollSum of a given player by 2
"
Class {
	#name : #OverloadEffect,
	#superclass : #CardPermanentEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
OverloadEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	super applyOn: target on: aGame triggeredBy: aPlayer.
	self assert: target size = 1 description: 'The overload card can only be played on a single player'.
	aGame addPlayedCard: (Card with: self) to: target by: aPlayer
]

{ #category : #accesing }
OverloadEffect >> value [
	^ -2
]
