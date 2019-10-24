"
This class models a given probability distribution of all spots
"
Class {
	#name : #OverallSpotDistribution,
	#superclass : #Object,
	#instVars : [
		'distribution'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
OverallSpotDistribution class >> probabilitiesAddUpToAHundred: distribution [
	self
		assert: (distribution collect: [ :each | each probability ]) sum = 100
]

{ #category : #'instance creation' }
OverallSpotDistribution class >> standard [
	^ self
		with:
			{(IndividualSpotDistribution of: AtomicBomb withProbability: 2).
			(IndividualSpotDistribution of: Regular withProbability: 55).
			(IndividualSpotDistribution of: MoonWalk withProbability: 5).
			(IndividualSpotDistribution of: SpeedUp withProbability: 15).
			(IndividualSpotDistribution of: TimeMachine withProbability: 8).
			(IndividualSpotDistribution of: WormHole withProbability: 15)}
]

{ #category : #validation }
OverallSpotDistribution class >> thereAreNoRepeatedSpotTypes: distribution [
	self
		assert:
			(distribution collect: [ :each | each spotType name ]) asSet size
				= distribution size
]

{ #category : #'instance creation' }
OverallSpotDistribution class >> with: distribution [
	self assert: distribution isNotEmpty.
	self thereAreNoRepeatedSpotTypes: distribution.
	self probabilitiesAddUpToAHundred: distribution.
	^ self new initializeWith: distribution
]

{ #category : #initialization }
OverallSpotDistribution >> initializeWith: aDistribution [
	distribution := aDistribution asOrderedCollection
]

{ #category : #accesing }
OverallSpotDistribution >> probabilityOf: typeOfSpot [
	^ (distribution
		select:
			[ :each | each spotType className asSymbol = typeOfSpot className asSymbol ])
		first probability
]

{ #category : #'spot-creation' }
OverallSpotDistribution >> randomSpot [
	| collection |
	collection := OrderedCollection new.
	distribution
		do: [ :each | 
			collection
				addAll: (OrderedCollection new: each probability withAll: each spotType) ].
	^ collection atRandom new
]
