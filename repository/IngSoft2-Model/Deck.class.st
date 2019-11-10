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
Deck class >> newLoadedWith: anEffect [
	^ self new initializeLoadedWith: anEffect
]

{ #category : #'instance creation' }
Deck class >> newStandard [
	^ self new initializeStandardDeck
]

{ #category : #initialization }
Deck >> initializeLoadedWith: anEffect [
	cardsDistribution := OverallOccurrenceDistribution
		with:
			{(IndividualOccurrenceProbability of: anEffect withProbability: 100)}
]

{ #category : #initialization }
Deck >> initializeStandardDeck [
	cardsDistribution := OverallOccurrenceDistribution
		with:
			{(IndividualOccurrenceProbability
				of: RepeatEffect new
				withProbability: 25).
			(IndividualOccurrenceProbability
				of: AccelerationEffect new
				withProbability: 25).
			(IndividualOccurrenceProbability
				of: OverloadEffect new
				withProbability: 25).
			(IndividualOccurrenceProbability
				of: SpeedEffect new
				withProbability: 25)}
]

{ #category : #accessing }
Deck >> nextCard [
	^ Card newWith: cardsDistribution random
]
