"
This class the probability of a specific spot type
"
Class {
	#name : #IndividualSpotDistribution,
	#superclass : #Object,
	#instVars : [
		'spotType',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
IndividualSpotDistribution class >> of: spotSubclass withProbability: probability [
	self assert: (probability >= 0 and: probability <= 100).
	self assert: (Spot allSubclasses includes: spotSubclass).
	^ self new
		initializeWithSpotType: spotSubclass
		andProbability: probability
]

{ #category : #initialization }
IndividualSpotDistribution >> initializeWithSpotType: spotSubclass andProbability: spotProbability [
	spotType := spotSubclass.
	probability := spotProbability
]

{ #category : #accessing }
IndividualSpotDistribution >> probability [
	^ probability copy
]

{ #category : #accessing }
IndividualSpotDistribution >> spotType [
	^ spotType copy
]
