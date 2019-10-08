"
A class used to create the board spots of the game
"
Class {
	#name : #Spot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'additional methods' }
Spot class >> idealDistribution [
	| idealDistribution |
	idealDistribution := Dictionary new.
	self allSubclasses
		do:
			[ :each | idealDistribution at: each name asSymbol put: each probability ].
	^ idealDistribution
]

{ #category : #'standard values' }
Spot class >> probability [
	self subclassResponsibility
]

{ #category : #'instance creation' }
Spot class >> random [
	| choiceCollection |
	choiceCollection := OrderedCollection new.
	self allSubclasses
		do:
			[ :each | each probability timesRepeat: [ choiceCollection add: each ] ].
	^ choiceCollection atRandom new
]

{ #category : #effect }
Spot >> applyEffecton: gameState triggeredBy: player [
	self subclassResponsibility
]
