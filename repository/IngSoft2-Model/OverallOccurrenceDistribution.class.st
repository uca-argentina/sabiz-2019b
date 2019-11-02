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

{ #category : #'spot-creation' }
OverallOccurrenceDistribution >> random [
	| collection |
	collection := OrderedCollection new.
	distribution
		do: [ :each | 
			collection
				addAll:
					(OrderedCollection
						new: each probability
						withAll: (each element)) ].
	^ collection atRandom
]
