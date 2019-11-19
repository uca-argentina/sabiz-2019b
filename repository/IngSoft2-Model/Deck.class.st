"
This class represents a Deck of cards
"
Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardsDistribution'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: cardTypes [
	self assert: [ cardTypes isNotEmpty ].
	^ self new
		initializeWith: (OverallOccurrenceDistribution evenDistributionFor: cardTypes)
]

{ #category : #initialization }
Deck >> initializeWith: distribution [
	cardsDistribution := distribution
]

{ #category : #accessing }
Deck >> nextCard [
	^ Card with: cardsDistribution random
]
