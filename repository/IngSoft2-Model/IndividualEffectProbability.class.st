"
This class the probability of a specific effect
"
Class {
	#name : #IndividualEffectProbability,
	#superclass : #Object,
	#instVars : [
		'probability',
		'effectType'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
IndividualEffectProbability class >> of: spotSubclass withProbability: probability [
	self assert: (probability >= 0 and: probability <= 100).
	self assert: (Effect allSubclasses includes: spotSubclass).
	^ self new
		initializeWith: spotSubclass
		andProbability: probability
]

{ #category : #accessing }
IndividualEffectProbability >> effectType [
	^ effectType copy
]

{ #category : #initialization }
IndividualEffectProbability >> initializeWith: spotSubclass andProbability: spotProbability [
	effectType := spotSubclass.
	probability := spotProbability
]

{ #category : #accessing }
IndividualEffectProbability >> probability [
	^ probability copy
]
