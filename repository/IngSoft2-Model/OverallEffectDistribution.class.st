"
This class models a given probability distribution of all effects
"
Class {
	#name : #OverallEffectDistribution,
	#superclass : #Object,
	#instVars : [
		'distribution'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
OverallEffectDistribution class >> probabilitiesAddUpToAHundred: distribution [
	self
		assert: (distribution collect: [ :each | each probability ]) sum = 100
]

{ #category : #'instance creation' }
OverallEffectDistribution class >> standard [
	^ self
		with:
			{(IndividualEffectProbability of: AtomicBomb withProbability: 2).
			(IndividualEffectProbability of: Regular withProbability: 55).
			(IndividualEffectProbability of: MoonWalk withProbability: 5).
			(IndividualEffectProbability of: SpeedUp withProbability: 15).
			(IndividualEffectProbability of: TimeMachine withProbability: 8).
			(IndividualEffectProbability of: WormHole withProbability: 15)}
]

{ #category : #validation }
OverallEffectDistribution class >> thereAreNoRepeatedSpotTypes: distribution [
	self
		assert:
			(distribution collect: [ :each | each effectType name ]) asSet size
				= distribution size
]

{ #category : #'instance creation' }
OverallEffectDistribution class >> with: distribution [
	self assert: distribution isNotEmpty.
	self thereAreNoRepeatedSpotTypes: distribution.
	self probabilitiesAddUpToAHundred: distribution.
	^ self new initializeWith: distribution
]

{ #category : #initialization }
OverallEffectDistribution >> initializeWith: aDistribution [
	distribution := aDistribution asOrderedCollection
]

{ #category : #accesing }
OverallEffectDistribution >> probabilityOf: typeOfSpot [
	^ (distribution
		select:
			[ :each | each effectType className asSymbol = typeOfSpot className asSymbol ])
		first probability
]

{ #category : #'spot-creation' }
OverallEffectDistribution >> spotWithRandomEffect [
	| collection |
	collection := OrderedCollection new.
	distribution
		do: [ :each | 
			collection
				addAll:
					(OrderedCollection
						new: each probability
						withAll: (Spot with: each effectType new)) ].
	^ collection atRandom
]
