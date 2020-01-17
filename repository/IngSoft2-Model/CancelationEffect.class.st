"
Removes a played card from the game
"
Class {
	#name : #CancelationEffect,
	#superclass : #CardInstantEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CancelationEffect >> applyOn: target on: aGame triggeredBy: aPlayer [
	self
		assert:
			(target class = PlayedCard
				and: [target effect class superclass = CardPermanentEffect])
		description:
			'The target of a cancelation card must be a played permanent effect card'.
	aGame removePlayedCard: target
]
