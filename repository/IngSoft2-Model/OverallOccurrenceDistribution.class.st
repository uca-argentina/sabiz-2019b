"
This class models a given probability distribution of all effects
"
Class {
	#name : #OverallOccurrenceDistribution,
	#superclass : #Object,
	#instVars : [
		'distribution'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverallOccurrenceDistribution class >> evenDistributionFor: elements [
	| probability |
	self assert: elements isNotEmpty.
	probability := 100 / elements size.
	^ self
		with:
			(elements
				collect:
					[ :each | IndividualOccurrenceProbability of: each withProbability: probability ])
				asArray
]

{ #category : #validation }
OverallOccurrenceDistribution class >> probabilitiesAddUpToAHundred: distribution [
	self
		assert: (distribution collect: [ :each | each probability ]) sum = 100
		description: 'Probabilities do not add up to a hundred'
]

{ #category : #'instance creation' }
OverallOccurrenceDistribution class >> with: distribution [
	self assert: distribution isNotEmpty description: 'Tried to create an empty distribution'.
	self probabilitiesAddUpToAHundred: distribution.
	^ self new initializeWith: distribution
]

{ #category : #generation }
OverallOccurrenceDistribution >> generate: numberOfElements [
	| elements |
	elements := OrderedCollection new.
	numberOfElements timesRepeat: [ elements add: self random ].
	^ elements
]

{ #category : #initialization }
OverallOccurrenceDistribution >> initializeWith: aDistribution [
	distribution := aDistribution asOrderedCollection
]

{ #category : #accessing }
OverallOccurrenceDistribution >> probabilityOf: element [
	^ (distribution
		select:
			[ :each | each element = element ])
		first probability
]

{ #category : #generation }
OverallOccurrenceDistribution >> random [
	| collection |
	collection := OrderedCollection new.
	distribution
		do: [ :each | 
			collection
				addAll:
					(OrderedCollection
						new: each probability rounded
						withAll: (each element)) ].
	^ collection atRandom
]
