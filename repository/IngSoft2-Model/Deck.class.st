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
	| individualProbability |
	self assert: [ cardTypes isNotEmpty ].
	individualProbability := 100 / cardTypes size.
	^ self new
		initializeWith:
			(OverallOccurrenceDistribution
				with:
					(cardTypes
						collect: [ :each | 
							IndividualOccurrenceProbability
								of: each
								withProbability: individualProbability ]) asArray)
]

{ #category : #initialization }
Deck >> initializeWith: distribution [
	cardsDistribution := distribution
]

{ #category : #accessing }
Deck >> nextCard [
	^ Card with: cardsDistribution random
]
